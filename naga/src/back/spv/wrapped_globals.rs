use crate::proc::{BoundsCheckPolicies, BoundsCheckPolicy};
use alloc::collections::BTreeSet;

#[test]
fn wrapped_global_matrix_accesses_remain_rooted_at_the_block() {
    let source = include_str!("../../../tests/in/wgsl/global-matrix-access.wgsl");
    let module = crate::front::wgsl::parse_str(source).unwrap();
    let info = crate::valid::Validator::new(
        crate::valid::ValidationFlags::all(),
        crate::valid::Capabilities::all(),
    )
    .validate(&module)
    .unwrap();

    for policy in [
        BoundsCheckPolicy::Unchecked,
        BoundsCheckPolicy::Restrict,
        BoundsCheckPolicy::ReadZeroSkipWrite,
    ] {
        let options = super::Options {
            bounds_check_policies: BoundsCheckPolicies {
                index: policy,
                buffer: policy,
                ..Default::default()
            },
            ..Default::default()
        };
        let words = super::write_vec(
            &module,
            &info,
            &options,
            Some(&super::PipelineOptions {
                shader_stage: crate::ShaderStage::Compute,
                entry_point: "main".into(),
            }),
        )
        .unwrap();
        let parsed = rspirv::dr::load_words(words).unwrap();
        let variables: BTreeSet<_> = parsed
            .all_inst_iter()
            .filter(|instruction| instruction.class.opcode == spirv::Op::Variable)
            .map(|instruction| instruction.result_id.unwrap())
            .collect();
        let accesses: alloc::vec::Vec<_> = parsed
            .all_inst_iter()
            .filter(|instruction| instruction.class.opcode == spirv::Op::AccessChain)
            .collect();
        assert!(!accesses.is_empty());
        for instruction in accesses {
            let result = instruction.result_id.unwrap();
            let rspirv::dr::Operand::IdRef(base) = instruction.operands[0] else {
                panic!("access-chain base is not an ID");
            };
            assert!(
                variables.contains(&base),
                "{policy:?}: access %{result} is rooted at an intermediate pointer %{base}"
            );
        }
        assert!(
            parsed
                .all_inst_iter()
                .any(|instruction| instruction.class.opcode == spirv::Op::ArrayLength),
            "runtime array lengths must remain available"
        );
    }
}
