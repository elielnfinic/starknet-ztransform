
from starkware.cairo.common.math import assert_nn, sqrt
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word 
from starkware.cairo.common.pow import pow
from lib.mathx64 import Math64x61

struct SpecialNumber{
    x : felt,
    y : felt,
}

func z_transform{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(ar : felt*, size : felt) -> (res : SpecialNumber){
    let div_ = Math64x61.exp(-3);
    let div_2 = Math64x61.div(1000,3);
    let j = 1000 / 3;
    %{ print(f"Division result is {ids.div_}") %}
    %{ print(f"Division result is {ids.div_2}") %}
    %{ print(f"Division result is {12/123}") %}
    z_go_through_array(ar, size, 0);
    return (res = SpecialNumber(x = 32,y = 64));
}

func z_go_through_array{range_check_ptr}(ar : felt*, size : felt, n : felt){
    if(n == size){
        %{ print("End array")%}
        return ();
    }

    let current_elt = [ar + n];
    %{print(f"Showing {ids.current_elt}")%}
    let (sum) = z_go_through_array_2(ar, size, 0, n);
    %{print(f"\tThe sum is {ids.sum}")%}
    z_go_through_array(ar, size, n + 1);
    return ();
}

func z_go_through_array_2{range_check_ptr}(ar : felt*, size : felt, n : felt, k : felt) -> (res : felt){
    alloc_locals;
    if(n == size){
        %{ print("\tEnd array")%}
        return (res = 0);
    }

    let current_elt = [ar + n];
    %{print(f"\tShowing {ids.current_elt} for k={ids.k} and n={ids.n}")%}
    
    let (next_sum) = z_go_through_array_2(ar, size, n + 1, k);
    let k_1 = k;
    let n_1 = n;
    let (local power) = pow(200,(k_1 * n_1));
    %{print(f"The power is {ids.power}")%}
    
    let sum = current_elt * power + next_sum;
    return (res = sum);     
}

func z_local_operation(ar : felt*, k : felt, n : felt){

}

func z_local_sum{range_check_ptr}(ar : felt*, size : felt) -> (res : felt){
    if(size == 0){
        return (res = 0);
    }

    let (recursive_val) = z_local_sum(ar + 1, size - 1);//, index + 1);
    //%{ print(f"Index is {ids.index}")%}
    let e : felt = 2;//2.71828182845904;
    let val = [ar];
    let (exp) = pow(e, -1);
    let exp = 2;
    let z = exp + recursive_val;
    let c = val + z;
    return (res = c);    
}
