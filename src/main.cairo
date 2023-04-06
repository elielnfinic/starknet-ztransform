%lang starknet


from starkware.cairo.common.math import assert_nn, sqrt
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word 
from starkware.cairo.common.pow import pow
from lib.mathx64 import Math64x61


from src.loops import z_go_through_array, z_go_through_array_2

@storage_var
func ztransform() -> (felt){
}

@storage_var
func admin() -> (felt){
}

struct Inputs{
    num_1 : felt, 
    num_2 : felt, 
    num_3 : felt, 
    num_4 : felt, 
    num_5 : felt,
}

struct Transform{
    x : felt, 
    num_1 : felt, 
    num_2 : felt, 
    num_3 : felt, 
    num_4 : felt, 
    num_5 : felt,
}

struct Ztrans{
    input: Inputs,
    transform : Transform,
}

@storage_var
func trans(user : felt) -> (res: Ztrans) {
}


func z_transform{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(ar : felt*, size : felt){
    alloc_locals;
    let (local freq_arr) = alloc();
    z_go_through_array(ar, size, 0, freq_arr);
    //Get second element of freq_arr
    let first_elt = [freq_arr];
    let second_elt = [freq_arr + 1];
    %{ print(f"First element is {ids.first_elt} {ids.second_elt}")%}
    return ();
}

@view
func z_transform_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}( ar_len : felt, ar : felt*)  -> (res_len : felt, res : felt*){
    alloc_locals;
    let (local freq_arr) = alloc();
    z_go_through_array(ar, ar_len, 0, freq_arr);
    //Get second element of freq_arr
    let first_elt = [freq_arr + 1];
    // %{ print(f"First element is {ids.first_elt}")%}
    return (res_len=1,res=freq_arr);
}


@view 
func get_increment{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(number : felt) -> (res : felt){
    let res = number + 12;
    return (res = res);
}

@external
func calc_and_save_trans{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(n1 : felt, n2 : felt, n3 : felt, n4 : felt, n5 : felt){
    alloc_locals;
    let (caller_address) = get_caller_address();

    let (local arr) = alloc();
    assert [arr] = n1; 
    assert [arr + 1] = n2; 
    assert [arr + 2] = n3; 
    assert [arr + 3] = n4; 
    assert [arr + 4] = n5;
    let (local freq_arr) = alloc();
    z_go_through_array(arr, 5, 0, freq_arr);
    let x1 = [freq_arr];
    let x2 = [freq_arr + 1];
    let x3 = [freq_arr + 2];
    let x4 = [freq_arr + 3];
    let x5 = [freq_arr + 4];
    
    // %{ print(f"x5 is {ids.x1}")%}

    let e = 2;

    let in_s = Inputs(num_1 = n1, num_2 = n2, num_3 = n3, num_4 = n4, num_5 = n5);
    let tr_s = Transform(x = e, num_1 = x2, num_2 = x3, num_3 = x4, num_4 = x5, num_5 = 0);
    let my_z_trans = Ztrans(input=in_s, transform = tr_s);
    trans.write(caller_address, my_z_trans);

    return ();
}

@view 
func get_my_trans{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(user_addr : felt) -> (z : Ztrans){
    let (z_trans) = trans.read(user_addr);
    return (z = z_trans);
}

@view
func calc_trans{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(n1 : felt, n2 : felt, n3 : felt, n4 : felt, n5 : felt) -> (z : Ztrans){
    alloc_locals;
    let (caller_address) = get_caller_address();

    let (local arr) = alloc();
    assert [arr] = n1; 
    assert [arr + 1] = n2; 
    assert [arr + 2] = n3; 
    assert [arr + 3] = n4; 
    assert [arr + 4] = n5;
    let (local freq_arr) = alloc();
    z_go_through_array(arr, 5, 0, freq_arr);
    let x1 = [freq_arr];
    let x2 = [freq_arr + 1];
    let x3 = [freq_arr + 2];
    let x4 = [freq_arr + 3];
    let x5 = [freq_arr + 4];

    let e = 2;

    let in_s = Inputs(num_1 = n1, num_2 = n2, num_3 = n3, num_4 = n4, num_5 = n5);
    let tr_s = Transform(x = e, num_1 = x2, num_2 = x3, num_3 = x4, num_4 = x5, num_5 = 0);
    let my_z_trans = Ztrans(input=in_s, transform = tr_s);

    return (z = my_z_trans);
}