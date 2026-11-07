#version 460
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct _7
{
    uint _m0;
    int _m1[2];
};

struct _10
{
    uint _m0;
    bool _m1;
};

struct _11
{
    int _m0;
    bool _m1;
};

layout(set = 0, binding = 0, std430) buffer _13_12
{
    uint _m0;
} _12;

layout(set = 0, binding = 1, std430) buffer _16_15
{
    int _m0[2];
} _15;

layout(set = 0, binding = 2, std430) buffer _19_18
{
    _7 _m0;
} _18;

shared uint _21;
shared int _23[2];
shared _7 _25;

void main()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _21 = 0u;
        _23 = int[](0, 0);
        _25 = _7(0u, int[](0, 0));
    }
    barrier();
    atomicExchange(_12._m0, 1u);
    atomicExchange(_15._m0[1u], 1);
    atomicExchange(_18._m0._m0, 1u);
    atomicExchange(_18._m0._m1[1u], 1);
    atomicExchange(_21, 1u);
    atomicExchange(_23[1u], 1);
    atomicExchange(_25._m0, 1u);
    atomicExchange(_25._m1[1u], 1);
    barrier();
    uint _65 = atomicAdd(_12._m0, 0u);
    int _67 = atomicAdd(_15._m0[1u], 0);
    uint _69 = atomicAdd(_18._m0._m0, 0u);
    int _71 = atomicAdd(_18._m0._m1[1u], 0);
    uint _72 = atomicAdd(_21, 0u);
    int _74 = atomicAdd(_23[1u], 0);
    uint _76 = atomicAdd(_25._m0, 0u);
    int _78 = atomicAdd(_25._m1[1u], 0);
    barrier();
    uint _79 = atomicAdd(_12._m0, 1u);
    int _81 = atomicAdd(_15._m0[1u], 1);
    uint _83 = atomicAdd(_18._m0._m0, 1u);
    int _85 = atomicAdd(_18._m0._m1[1u], 1);
    uint _87 = atomicAdd(_21, 1u);
    int _88 = atomicAdd(_23[1u], 1);
    uint _90 = atomicAdd(_25._m0, 1u);
    int _92 = atomicAdd(_25._m1[1u], 1);
    barrier();
    uint _94 = atomicAdd(_12._m0, -1u);
    int _96 = atomicAdd(_15._m0[1u], -1);
    uint _98 = atomicAdd(_18._m0._m0, -1u);
    int _100 = atomicAdd(_18._m0._m1[1u], -1);
    uint _102 = atomicAdd(_21, -1u);
    int _103 = atomicAdd(_23[1u], -1);
    uint _105 = atomicAdd(_25._m0, -1u);
    int _107 = atomicAdd(_25._m1[1u], -1);
    barrier();
    uint _109 = atomicMax(_12._m0, 1u);
    int _111 = atomicMax(_15._m0[1u], 1);
    uint _113 = atomicMax(_18._m0._m0, 1u);
    int _115 = atomicMax(_18._m0._m1[1u], 1);
    uint _117 = atomicMax(_21, 1u);
    int _118 = atomicMax(_23[1u], 1);
    uint _120 = atomicMax(_25._m0, 1u);
    int _122 = atomicMax(_25._m1[1u], 1);
    barrier();
    uint _124 = atomicMin(_12._m0, 1u);
    int _126 = atomicMin(_15._m0[1u], 1);
    uint _128 = atomicMin(_18._m0._m0, 1u);
    int _130 = atomicMin(_18._m0._m1[1u], 1);
    uint _132 = atomicMin(_21, 1u);
    int _133 = atomicMin(_23[1u], 1);
    uint _135 = atomicMin(_25._m0, 1u);
    int _137 = atomicMin(_25._m1[1u], 1);
    barrier();
    uint _139 = atomicAnd(_12._m0, 1u);
    int _141 = atomicAnd(_15._m0[1u], 1);
    uint _143 = atomicAnd(_18._m0._m0, 1u);
    int _145 = atomicAnd(_18._m0._m1[1u], 1);
    uint _147 = atomicAnd(_21, 1u);
    int _148 = atomicAnd(_23[1u], 1);
    uint _150 = atomicAnd(_25._m0, 1u);
    int _152 = atomicAnd(_25._m1[1u], 1);
    barrier();
    uint _154 = atomicOr(_12._m0, 1u);
    int _156 = atomicOr(_15._m0[1u], 1);
    uint _158 = atomicOr(_18._m0._m0, 1u);
    int _160 = atomicOr(_18._m0._m1[1u], 1);
    uint _162 = atomicOr(_21, 1u);
    int _163 = atomicOr(_23[1u], 1);
    uint _165 = atomicOr(_25._m0, 1u);
    int _167 = atomicOr(_25._m1[1u], 1);
    barrier();
    uint _169 = atomicXor(_12._m0, 1u);
    int _171 = atomicXor(_15._m0[1u], 1);
    uint _173 = atomicXor(_18._m0._m0, 1u);
    int _175 = atomicXor(_18._m0._m1[1u], 1);
    uint _177 = atomicXor(_21, 1u);
    int _178 = atomicXor(_23[1u], 1);
    uint _180 = atomicXor(_25._m0, 1u);
    int _182 = atomicXor(_25._m1[1u], 1);
    uint _184 = atomicExchange(_12._m0, 1u);
    int _186 = atomicExchange(_15._m0[1u], 1);
    uint _188 = atomicExchange(_18._m0._m0, 1u);
    int _190 = atomicExchange(_18._m0._m1[1u], 1);
    uint _192 = atomicExchange(_21, 1u);
    int _193 = atomicExchange(_23[1u], 1);
    uint _195 = atomicExchange(_25._m0, 1u);
    int _197 = atomicExchange(_25._m1[1u], 1);
    uint _201 = atomicCompSwap(_12._m0, 1u, 2u);
    int _205 = atomicCompSwap(_15._m0[1u], 1, 2);
    uint _209 = atomicCompSwap(_18._m0._m0, 1u, 2u);
    int _213 = atomicCompSwap(_18._m0._m1[1u], 1, 2);
    uint _216 = atomicCompSwap(_21, 1u, 2u);
    int _220 = atomicCompSwap(_23[1u], 1, 2);
    uint _224 = atomicCompSwap(_25._m0, 1u, 2u);
    int _228 = atomicCompSwap(_25._m1[1u], 1, 2);
}

