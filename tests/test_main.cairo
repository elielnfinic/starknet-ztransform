%lang starknet

from src.main import z_transform
from starkware.cairo.common.alloc import alloc 
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import HashBuiltin

@external 
func test_z_transform{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(){
    alloc_locals;

    let arr_size = 5;
    let (local freq) = alloc();
    assert [freq] = 1;
    assert [freq + 1] = 2;
    assert [freq + 2] = 3;
    assert [freq + 3] = 4;
    assert [freq + 4] = 5;

    z_transform(freq, arr_size);

    assert 1 = 1;

    return ();
}