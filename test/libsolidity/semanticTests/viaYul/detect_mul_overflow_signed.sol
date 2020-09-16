contract C {
    function f(int a, int b) public pure returns (int x) {
        x = a * b;
    }
    function g(int8 a, int8 b) public pure returns (int8 x) {
        x = a * b;
    }
}
// ====
// compileViaYul: also
// ----
// f(int256,int256): 5, 6 -> 30
// f(int256,int256): -1, 1 -> -1
// f(int256,int256): -1, 2 -> -2 # positive, positive #
// f(int256,int256): 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 2 -> 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
// f(int256,int256): 0x4000000000000000000000000000000000000000000000000000000000000000, 2 -> FAILURE, hex"1f825c6a"
// f(int256,int256): 2, 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF -> 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
// f(int256,int256): 2, 0x4000000000000000000000000000000000000000000000000000000000000000 -> FAILURE, hex"1f825c6a" # positive, negative #
// f(int256,int256): 0x4000000000000000000000000000000000000000000000000000000000000000, -2 -> 0x8000000000000000000000000000000000000000000000000000000000000000
// f(int256,int256): 0x4000000000000000000000000000000000000000000000000000000000000001, -2 -> FAILURE, hex"1f825c6a"
// f(int256,int256): 2, 0xC000000000000000000000000000000000000000000000000000000000000000 -> 0x8000000000000000000000000000000000000000000000000000000000000000
// f(int256,int256): 2, 0xBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF -> FAILURE, hex"1f825c6a" # negative, positive #
// f(int256,int256): -2, 0x4000000000000000000000000000000000000000000000000000000000000000 -> 0x8000000000000000000000000000000000000000000000000000000000000000
// f(int256,int256): -2, 0x4000000000000000000000000000000000000000000000000000000000000001 -> FAILURE, hex"1f825c6a"
// f(int256,int256): 0xC000000000000000000000000000000000000000000000000000000000000000, 2 -> 0x8000000000000000000000000000000000000000000000000000000000000000
// f(int256,int256): 0xBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 2 -> FAILURE, hex"1f825c6a" # negative, negative #
// f(int256,int256): 0xC000000000000000000000000000000000000000000000000000000000000001, -2 -> 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
// f(int256,int256): 0xC000000000000000000000000000000000000000000000000000000000000000, -2 -> FAILURE, hex"1f825c6a"
// f(int256,int256): -2, 0xC000000000000000000000000000000000000000000000000000000000000001 -> 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
// f(int256,int256): -2, 0xC000000000000000000000000000000000000000000000000000000000000000 -> FAILURE, hex"1f825c6a" # small type #
// g(int8,int8): 5, 6 -> 30
// g(int8,int8): -1, 1 -> -1
// g(int8,int8): -1, 2 -> -2 # positive, positive #
// g(int8,int8): 63, 2 -> 126
// g(int8,int8): 64, 2 -> FAILURE, hex"1f825c6a"
// g(int8,int8): 2, 63 -> 126
// g(int8,int8): 2, 64 -> FAILURE, hex"1f825c6a" # positive, negative #
// g(int8,int8): 64, -2 -> -128
// g(int8,int8): 65, -2 -> FAILURE, hex"1f825c6a"
// g(int8,int8): 2, -64 -> -128
// g(int8,int8): 2, -65 -> FAILURE, hex"1f825c6a" # negative, positive #
// g(int8,int8): -2, 64 -> -128
// g(int8,int8): -2, 65 -> FAILURE, hex"1f825c6a"
// g(int8,int8): -64, 2 -> -128
// g(int8,int8): -65, 2 -> FAILURE, hex"1f825c6a" # negative, negative #
// g(int8,int8): -63, -2 -> 126
// g(int8,int8): -64, -2 -> FAILURE, hex"1f825c6a"
// g(int8,int8): -2, -63 -> 126
// g(int8,int8): -2, -64 -> FAILURE, hex"1f825c6a"
