#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _16_15
{
    mat4 _m0[];
} _15;

layout(set = 0, binding = 1, std430) buffer _19_18
{
    mat4 _m0[];
} _18;

layout(set = 0, binding = 2, std430) readonly buffer _22_21
{
    mat4 _m0[2];
} _21;

layout(set = 0, binding = 3, std430) readonly buffer _25_24
{
    mat4 _m0[2][2];
} _24;

layout(set = 0, binding = 4, std430) readonly buffer _28_27
{
    mat4 _m0;
} _27;

layout(set = 0, binding = 5, std140) uniform _31_30
{
    mat4 _m0;
} _30;

layout(set = 0, binding = 6, std430) readonly buffer _7_33
{
    mat4 _m0[];
} _33;

layout(set = 0, binding = 7, std430) buffer _36_35
{
    vec4 _m0[];
} _35;

uint _38(uint _40, uint _41)
{
    return _40 % ((_41 == 0u) ? 1u : _41);
}

void main()
{
    bool _69 = false;
    uint _75 = _38(gl_GlobalInvocationID.y, 4u);
    vec4 _78 = _15._m0[gl_GlobalInvocationID.x][_75];
    vec4 _81 = _21._m0[_38(gl_GlobalInvocationID.x, 2u)][_75];
    vec4 _87 = _24._m0[_38(gl_GlobalInvocationID.x, 2u)][_38(gl_GlobalInvocationID.x + 1u, 2u)][_75];
    vec4 _90 = _27._m0[_75];
    vec4 _97 = _33._m0[gl_GlobalInvocationID.x][_75];
    vec4 _98 = ((((_78 + _81) + _87) + _90) + _30._m0[_75]) + _97;
    _18._m0[gl_GlobalInvocationID.x][_75] = _98;
    _35._m0[(gl_GlobalInvocationID.x * 4u) + _75] = _98;
    if (gl_GlobalInvocationID.x == 0u)
    {
        _69 = _75 == 0u;
    }
    else
    {
        _69 = false;
    }
    if (_69)
    {
        _35._m0[8u] = vec4(float(uint(_15._m0.length())), float(uint(_33._m0.length())), _15._m0[0u][3u].x, _27._m0[3u].y);
        return;
    }
    else
    {
        return;
    }
}

