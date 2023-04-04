
from starkware.cairo.common.math import assert_nn, sqrt
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word 
from starkware.cairo.common.pow import pow
from lib.mathx64 import Math64x61

from src.loops import z_go_through_array, z_go_through_array_2

struct SpecialNumber{
    x : felt,
    y : felt,
}

func z_transform{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(ar : felt*, size : felt){
    alloc_locals;
    let (local freq_arr) = alloc();
    z_go_through_array(ar, size, 0, freq_arr);
    //Get second element of freq_arr
    let first_elt = [freq_arr + 1];
    %{ print(f"First element is {ids.first_elt}")%}
    return ();
}

