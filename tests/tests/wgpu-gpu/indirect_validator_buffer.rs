use wgpu::util::DeviceExt as _;
use wgpu_test::{
    gpu_test, GpuTestConfiguration, GpuTestInitializer, TestParameters, TestingContext,
};

pub fn all_tests(tests: &mut Vec<GpuTestInitializer>) {
    tests.push(INDIRECT_VALIDATOR_BUFFER);
}

#[gpu_test]
static INDIRECT_VALIDATOR_BUFFER: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(wgpu::Features::IMMEDIATES)
            .limits(wgpu::Limits {
                max_immediate_size: 8,
                ..wgpu::Limits::downlevel_defaults()
            }),
    )
    .run_async(indirect_validator_buffer);

async fn indirect_validator_buffer(ctx: TestingContext) {
    let shader = ctx
        .device
        .create_shader_module(wgpu::ShaderModuleDescriptor {
            label: None,
            source: wgpu::ShaderSource::Wgsl(
                include_str!("../../../wgpu-core/src/indirect_validation/validate_draw.wgsl")
                    .into(),
            ),
        });
    let layouts: Vec<_> = (0..3)
        .map(|i| {
            ctx.device
                .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                    label: None,
                    entries: &[wgpu::BindGroupLayoutEntry {
                        binding: 0,
                        visibility: wgpu::ShaderStages::COMPUTE,
                        ty: wgpu::BindingType::Buffer {
                            ty: wgpu::BufferBindingType::Storage { read_only: i != 2 },
                            has_dynamic_offset: false,
                            min_binding_size: None,
                        },
                        count: None,
                    }],
                })
        })
        .collect();
    let layout = ctx
        .device
        .create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
            label: None,
            bind_group_layouts: &[Some(&layouts[0]), Some(&layouts[1]), Some(&layouts[2])],
            immediate_size: 8,
        });
    let pipeline = ctx
        .device
        .create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
            label: None,
            layout: Some(&layout),
            module: &shader,
            entry_point: Some("main"),
            cache: None,
            compilation_options: wgpu::PipelineCompilationOptions {
                constants: &[
                    ("supports_indirect_first_instance", 1.0),
                    ("write_d3d12_special_constants", 0.0),
                ],
                ..Default::default()
            },
        });
    let data: [Vec<u32>; 3] = [
        vec![
            0x80000000,
            0,
            10000,
            u32::MAX,
            0x80000005,
            0x80000005,
            10000,
            u32::MAX - 1,
            0x8000000a,
            10,
            10000,
            1,
        ],
        vec![6, 3, 42, 24, 0, 6, 3, 42, 24, 0, 6, 3, 42, 24, 0],
        vec![0; 15],
    ];
    let buffers: Vec<_> = data
        .iter()
        .map(|words| {
            ctx.device
                .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                    label: None,
                    contents: bytemuck::cast_slice(words),
                    usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_SRC,
                })
        })
        .collect();
    let groups: Vec<_> = (0..3)
        .map(|i| {
            ctx.device.create_bind_group(&wgpu::BindGroupDescriptor {
                label: None,
                layout: &layouts[i],
                entries: &[wgpu::BindGroupEntry {
                    binding: 0,
                    resource: buffers[i].as_entire_binding(),
                }],
            })
        })
        .collect();
    let staging = ctx.device.create_buffer(&wgpu::BufferDescriptor {
        label: None,
        size: 168,
        usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
        mapped_at_creation: false,
    });
    let mut encoder = ctx.device.create_command_encoder(&Default::default());
    {
        let mut pass = encoder.begin_compute_pass(&Default::default());
        pass.set_pipeline(&pipeline);
        for (i, group) in groups.iter().enumerate() {
            pass.set_bind_group(i as u32, group, &[]);
        }
        pass.set_immediates(0, bytemuck::cast_slice(&[0u32, 3u32]));
        pass.dispatch_workgroups(1, 1, 1);
    }
    encoder.copy_buffer_to_buffer(&buffers[0], 0, &staging, 0, 48);
    encoder.copy_buffer_to_buffer(&buffers[1], 0, &staging, 48, 60);
    encoder.copy_buffer_to_buffer(&buffers[2], 0, &staging, 108, 60);
    ctx.queue.submit([encoder.finish()]);
    staging
        .slice(..)
        .map_async(wgpu::MapMode::Read, Result::unwrap);
    ctx.async_poll(wgpu::PollType::wait_indefinitely())
        .await
        .unwrap();
    {
        let bytes = staging.slice(..).get_mapped_range().unwrap();
        let words: &[u32] = bytemuck::cast_slice(&bytes);
        assert_eq!(&words[..12], data[0]);
        assert_eq!(&words[12..27], data[1]);
        assert_eq!(
            &words[27..],
            &[6, 3, 42, 24, 0, 6, 3, 42, 24, 0, 0, 0, 0, 0, 0]
        );
    }
    staging.unmap();
}
