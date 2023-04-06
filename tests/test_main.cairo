%lang starknet

from src.main import z_transform, calc_trans
from starkware.cairo.common.alloc import alloc 
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import HashBuiltin

@external 
func test_z_transform{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(){
    alloc_locals;

    let arr_size = 5;
    let (local freq) = alloc();
    assert [freq] = 12;
    assert [freq + 1] = 0;
    assert [freq + 2] = 1;
    assert [freq + 3] = 0;
    assert [freq + 4] = 1;

    z_transform(freq, arr_size);

    assert 1 = 1;

    return ();
}

@external 
func test_sm_c_z_calc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(){
    calc_trans(1, 2, 3, 4, 5);
    
    return ();
}