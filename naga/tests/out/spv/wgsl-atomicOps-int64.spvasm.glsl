#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
#extension GL_EXT_shader_atomic_int64 : require
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint64_t _m0;
    int64_t _m1[2];
};

struct _11
{
    uint64_t _m0;
    bool _m1;
};

struct _12
{
    int64_t _m0;
    bool _m1;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint64_t _m0;
} _13;

layout(set = 0, binding = 1, std430) buffer _17_16
{
    int64_t _m0[2];
} _16;

layout(set = 0, binding = 2, std430) buffer _20_19
{
    _8 _m0;
} _19;

shared uint64_t _22;
shared int64_t _24[2];
shared _8 _26;

void main()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _22 = 0ul;
        _24 = int64_t[](0l, 0l);
        _26 = _8(0ul, int64_t[](0l, 0l));
    }
    barrier();
    atomicExchange(_13._m0, 1ul);
    atomicExchange(_16._m0[1u], 1l);
    atomicExchange(_19._m0._m0, 1ul);
    atomicExchange(_19._m0._m1[1u], 1l);
    atomicExchange(_22, 1ul);
    atomicExchange(_24[1u], 1l);
    atomicExchange(_26._m0, 1ul);
    atomicExchange(_26._m1[1u], 1l);
    barrier();
    uint64_t _71 = atomicAdd(_13._m0, 0);
    int64_t _73 = atomicAdd(_16._m0[1u], 0);
    uint64_t _75 = atomicAdd(_19._m0._m0, 0);
    int64_t _77 = atomicAdd(_19._m0._m1[1u], 0);
    uint64_t _78 = atomicAdd(_22, 0);
    int64_t _80 = atomicAdd(_24[1u], 0);
    uint64_t _82 = atomicAdd(_26._m0, 0);
    int64_t _84 = atomicAdd(_26._m1[1u], 0);
    barrier();
    uint64_t _85 = atomicAdd(_13._m0, 1ul);
    int64_t _87 = atomicAdd(_16._m0[1u], 1l);
    uint64_t _89 = atomicAdd(_19._m0._m0, 1ul);
    int64_t _91 = atomicAdd(_19._m0._m1[1u], 1l);
    uint64_t _93 = atomicAdd(_22, 1ul);
    int64_t _94 = atomicAdd(_24[1u], 1l);
    uint64_t _96 = atomicAdd(_26._m0, 1ul);
    int64_t _98 = atomicAdd(_26._m1[1u], 1l);
    barrier();
    uint64_t _100 = atomicAdd(_13._m0, -1ul);
    int64_t _102 = atomicAdd(_16._m0[1u], -1l);
    uint64_t _104 = atomicAdd(_19._m0._m0, -1ul);
    int64_t _106 = atomicAdd(_19._m0._m1[1u], -1l);
    uint64_t _108 = atomicAdd(_22, -1ul);
    int64_t _109 = atomicAdd(_24[1u], -1l);
    uint64_t _111 = atomicAdd(_26._m0, -1ul);
    int64_t _113 = atomicAdd(_26._m1[1u], -1l);
    barrier();
    uint64_t _115 = atomicMax(_13._m0, 1ul);
    int64_t _117 = atomicMax(_16._m0[1u], 1l);
    uint64_t _119 = atomicMax(_19._m0._m0, 1ul);
    int64_t _121 = atomicMax(_19._m0._m1[1u], 1l);
    uint64_t _123 = atomicMax(_22, 1ul);
    int64_t _124 = atomicMax(_24[1u], 1l);
    uint64_t _126 = atomicMax(_26._m0, 1ul);
    int64_t _128 = atomicMax(_26._m1[1u], 1l);
    barrier();
    uint64_t _130 = atomicMin(_13._m0, 1ul);
    int64_t _132 = atomicMin(_16._m0[1u], 1l);
    uint64_t _134 = atomicMin(_19._m0._m0, 1ul);
    int64_t _136 = atomicMin(_19._m0._m1[1u], 1l);
    uint64_t _138 = atomicMin(_22, 1ul);
    int64_t _139 = atomicMin(_24[1u], 1l);
    uint64_t _141 = atomicMin(_26._m0, 1ul);
    int64_t _143 = atomicMin(_26._m1[1u], 1l);
    barrier();
    uint64_t _145 = atomicAnd(_13._m0, 1ul);
    int64_t _147 = atomicAnd(_16._m0[1u], 1l);
    uint64_t _149 = atomicAnd(_19._m0._m0, 1ul);
    int64_t _151 = atomicAnd(_19._m0._m1[1u], 1l);
    uint64_t _153 = atomicAnd(_22, 1ul);
    int64_t _154 = atomicAnd(_24[1u], 1l);
    uint64_t _156 = atomicAnd(_26._m0, 1ul);
    int64_t _158 = atomicAnd(_26._m1[1u], 1l);
    barrier();
    uint64_t _160 = atomicOr(_13._m0, 1ul);
    int64_t _162 = atomicOr(_16._m0[1u], 1l);
    uint64_t _164 = atomicOr(_19._m0._m0, 1ul);
    int64_t _166 = atomicOr(_19._m0._m1[1u], 1l);
    uint64_t _168 = atomicOr(_22, 1ul);
    int64_t _169 = atomicOr(_24[1u], 1l);
    uint64_t _171 = atomicOr(_26._m0, 1ul);
    int64_t _173 = atomicOr(_26._m1[1u], 1l);
    barrier();
    uint64_t _175 = atomicXor(_13._m0, 1ul);
    int64_t _177 = atomicXor(_16._m0[1u], 1l);
    uint64_t _179 = atomicXor(_19._m0._m0, 1ul);
    int64_t _181 = atomicXor(_19._m0._m1[1u], 1l);
    uint64_t _183 = atomicXor(_22, 1ul);
    int64_t _184 = atomicXor(_24[1u], 1l);
    uint64_t _186 = atomicXor(_26._m0, 1ul);
    int64_t _188 = atomicXor(_26._m1[1u], 1l);
    uint64_t _190 = atomicExchange(_13._m0, 1ul);
    int64_t _192 = atomicExchange(_16._m0[1u], 1l);
    uint64_t _194 = atomicExchange(_19._m0._m0, 1ul);
    int64_t _196 = atomicExchange(_19._m0._m1[1u], 1l);
    uint64_t _198 = atomicExchange(_22, 1ul);
    int64_t _199 = atomicExchange(_24[1u], 1l);
    uint64_t _201 = atomicExchange(_26._m0, 1ul);
    int64_t _203 = atomicExchange(_26._m1[1u], 1l);
    uint64_t _207 = atomicCompSwap(_13._m0, 1ul, 2ul);
    int64_t _211 = atomicCompSwap(_16._m0[1u], 1l, 2l);
    uint64_t _215 = atomicCompSwap(_19._m0._m0, 1ul, 2ul);
    int64_t _219 = atomicCompSwap(_19._m0._m1[1u], 1l, 2l);
    uint64_t _222 = atomicCompSwap(_22, 1ul, 2ul);
    int64_t _226 = atomicCompSwap(_24[1u], 1l, 2l);
    uint64_t _230 = atomicCompSwap(_26._m0, 1ul, 2ul);
    int64_t _234 = atomicCompSwap(_26._m1[1u], 1l, 2l);
}

