struct MatrixBlock {
    data: array<mat4x4<f32>>,
}

@group(0) @binding(0) var<storage, read> dynamic_matrices: array<mat4x4<f32>>;
@group(0) @binding(1) var<storage, read_write> writable_matrices: array<mat4x4<f32>>;
@group(0) @binding(2) var<storage, read> fixed_matrices: array<mat4x4<f32>, 2>;
@group(0) @binding(3) var<storage, read> nested_matrices: array<array<mat4x4<f32>, 2>, 2>;
@group(0) @binding(4) var<storage, read> direct_matrix: mat4x4<f32>;
@group(0) @binding(5) var<uniform> uniform_matrix: mat4x4<f32>;
@group(0) @binding(6) var<storage, read> explicit_block: MatrixBlock;
@group(0) @binding(7) var<storage, read_write> result: array<vec4<f32>>;

@compute @workgroup_size(1)
fn main(@builtin(global_invocation_id) id: vec3<u32>) {
    let i = id.x;
    let column = id.y % 4u;
    let sum = dynamic_matrices[i][column]
        + fixed_matrices[i % 2u][column]
        + nested_matrices[i % 2u][(i + 1u) % 2u][column]
        + direct_matrix[column]
        + uniform_matrix[column]
        + explicit_block.data[i][column];
    writable_matrices[i][column] = sum;
    result[i * 4u + column] = sum;
    if i == 0u && column == 0u {
        result[8u] = vec4<f32>(f32(arrayLength(&dynamic_matrices)),
            f32(arrayLength(&explicit_block.data)), dynamic_matrices[0][3].x, direct_matrix[3].y);
    }
}
