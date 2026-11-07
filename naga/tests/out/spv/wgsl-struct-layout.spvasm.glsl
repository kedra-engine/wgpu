///////////////////////////////////////////
// Entry point: "no_padding_frag" (frag) //
///////////////////////////////////////////
#version 460

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    vec3 _m1;
    float _m2;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _5 _m0;
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    _5 _m0;
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _7 _m0;
} _14;

layout(set = 0, binding = 3, std430) buffer _18_17
{
    _7 _m0;
} _17;

layout(location = 0) in vec3 _22;
layout(location = 1) in float _25;
layout(location = 0) out vec4 _28;

void main()
{
    _28 = vec4(0.0);
}


///////////////////////////////////////////
// Entry point: "no_padding_vert" (vert) //
///////////////////////////////////////////
#version 460

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    vec3 _m1;
    float _m2;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _5 _m0;
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    _5 _m0;
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _7 _m0;
} _14;

layout(set = 0, binding = 3, std430) buffer _18_17
{
    _7 _m0;
} _17;

layout(location = 0) in vec3 _37;
layout(location = 1) in float _39;

void main()
{
    gl_Position = vec4(0.0);
}


///////////////////////////////////////////
// Entry point: "no_padding_comp" (comp) //
///////////////////////////////////////////
#version 460
layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    vec3 _m1;
    float _m2;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _5 _m0;
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    _5 _m0;
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _7 _m0;
} _14;

layout(set = 0, binding = 3, std430) buffer _18_17
{
    _7 _m0;
} _17;

void main()
{
    _5 _52 = _5(vec3(0.0), 0.0);
    _52 = _8._m0;
    _52 = _11._m0;
}


//////////////////////////////////////////////
// Entry point: "needs_padding_frag" (frag) //
//////////////////////////////////////////////
#version 460

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    vec3 _m1;
    float _m2;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _5 _m0;
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    _5 _m0;
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _7 _m0;
} _14;

layout(set = 0, binding = 3, std430) buffer _18_17
{
    _7 _m0;
} _17;

layout(location = 0) in float _62;
layout(location = 1) in vec3 _64;
layout(location = 2) in float _66;
layout(location = 0) out vec4 _68;

void main()
{
    _68 = vec4(0.0);
}


//////////////////////////////////////////////
// Entry point: "needs_padding_vert" (vert) //
//////////////////////////////////////////////
#version 460

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    vec3 _m1;
    float _m2;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _5 _m0;
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    _5 _m0;
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _7 _m0;
} _14;

layout(set = 0, binding = 3, std430) buffer _18_17
{
    _7 _m0;
} _17;

layout(location = 0) in float _73;
layout(location = 1) in vec3 _75;
layout(location = 2) in float _77;

void main()
{
    gl_Position = vec4(0.0);
}


//////////////////////////////////////////////
// Entry point: "needs_padding_comp" (comp) //
//////////////////////////////////////////////
#version 460
layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    vec3 _m1;
    float _m2;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _5 _m0;
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    _5 _m0;
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _7 _m0;
} _14;

layout(set = 0, binding = 3, std430) buffer _18_17
{
    _7 _m0;
} _17;

void main()
{
    _7 _88 = _7(0.0, vec3(0.0), 0.0);
    _88 = _14._m0;
    _88 = _17._m0;
}

