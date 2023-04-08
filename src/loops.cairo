from starkware.cairo.common.pow import pow
from lib.mathx64 import Math64x61

func z_go_through_array{range_check_ptr}(ar : felt*, size : felt, n : felt, freq_arr : felt*){
    if(n == size){
        return ();
    }

    let current_elt = [ar + n];
    let (sum) = z_go_through_array_2(ar, size, 0, n);
    assert [freq_arr + n] = sum;
    z_go_through_array(ar, size, n + 1, freq_arr);
    return ();
}

func z_go_through_array_2{range_check_ptr}(ar : felt*, size : felt, n : felt, k : felt) -> (res : felt){
    alloc_locals;
    if(n == size){
        return (res = 0);
    }

    let current_elt = [ar + n];
    let e = 3;
    
    let (next_sum) = z_go_through_array_2(ar, size, n + 1, k);
    let k_1 = k;
    let n_1 = n;
    let (local power) = pow(e,(k_1 * n_1));
    
    let sum = current_elt * power + next_sum;
    return (res = sum);     
}