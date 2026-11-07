use wgpu::util::DeviceExt as _;
use wgpu_test::{
    gpu_test, GpuTestConfiguration, GpuTestInitializer, TestParameters, TestingContext,
};

pub fn all_tests(tests: &mut Vec<GpuTestInitializer>) {
    tests.push(GLOBAL_MATRIX_BUFFER_ACCESS);
}

#[gpu_test]
static GLOBAL_MATRIX_BUFFER_ACCESS: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .test_features_limits()
            .limits(wgpu::Limits {
                max_storage_buffers_per_shader_stage: 7,
                ..wgpu::Limits::downlevel_defaults()
            }),
    )
    .run_async(global_matrix_buffer_access);

async fn global_matrix_buffer_access(ctx: TestingContext) {
    let shader = ctx
        .device
        .create_shader_module(wgpu::ShaderModuleDescriptor {
            label: Some("global matrix access"),
            source: wgpu::ShaderSource::Wgsl(
                include_str!("../../../naga/tests/in/wgsl/global-matrix-access.wgsl").into(),
            ),
        });
    let pipeline = ctx
        .device
        .create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
            label: None,
            layout: None,
            module: &shader,
            entry_point: Some("main"),
            compilation_options: Default::default(),
            cache: None,
        });
    let buffers: Vec<_> = [2, 2, 2, 4, 1, 1, 2, 0]
        .into_iter()
        .enumerate()
        .map(|(binding, matrices)| {
            let data: Vec<f32> = if binding == 7 {
                vec![0.; 36]
            } else {
                (1..=matrices * 16).map(|value| value as f32).collect()
            };
            let usage = if binding == 5 {
                wgpu::BufferUsages::UNIFORM
            } else {
                wgpu::BufferUsages::STORAGE
            };
            ctx.device
                .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                    label: None,
                    contents: bytemuck::cast_slice(&data),
                    usage: usage | wgpu::BufferUsages::COPY_SRC,
                })
        })
        .collect();
    let entries: Vec<_> = buffers
        .iter()
        .enumerate()
        .map(|(binding, buffer)| wgpu::BindGroupEntry {
            binding: binding as u32,
            resource: buffer.as_entire_binding(),
        })
        .collect();
    let group = ctx.device.create_bind_group(&wgpu::BindGroupDescriptor {
        label: None,
        layout: &pipeline.get_bind_group_layout(0),
        entries: &entries,
    });
    let staging = ctx.device.create_buffer(&wgpu::BufferDescriptor {
        label: None,
        size: 272,
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
        mapped_at_creation: false,
    });
    let mut encoder = ctx.device.create_command_encoder(&Default::default());
    {
        let mut pass = encoder.begin_compute_pass(&Default::default());
        pass.set_pipeline(&pipeline);
        pass.set_bind_group(0, &group, &[]);
        pass.dispatch_workgroups(2, 4, 1);
    }
    encoder.copy_buffer_to_buffer(&buffers[7], 0, &staging, 0, 144);
    encoder.copy_buffer_to_buffer(&buffers[1], 0, &staging, 144, 128);
    ctx.queue.submit([encoder.finish()]);
    staging
        .slice(..)
        .map_async(wgpu::MapMode::Read, Result::unwrap);
    ctx.async_poll(wgpu::PollType::wait_indefinitely())
        .await
        .unwrap();
    {
        let view = staging.slice(..).get_mapped_range().unwrap();
        let actual: &[f32] = bytemuck::cast_slice(&view);
        let sums: Vec<f32> = (0..32)
            .map(|index| {
                let matrix = index / 16;
                let element = index % 16;
                6. * (element + 1) as f32 + if matrix == 0 { 16. } else { 80. }
            })
            .collect();
        let mut expected = sums.clone();
        expected.extend([2., 2., 13., 14.]);
        expected.extend(sums);
        assert_eq!(actual, expected);
    }
    staging.unmap();
}
