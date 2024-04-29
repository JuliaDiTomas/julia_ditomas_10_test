// Testing encode and decode instructions
// Test organization modeled after phase8_simpletest

// Section .crt0 is always placed from address 0
	.section .crt0, "ax"

//Symbol start is used to obtain entry point information
_start:
    .global _start

    # Test 1, no errors (a couple of different cases)
    li x2, 0x12
    slli x2, x2, 8
    ori x2, x2, 0x34  # value to write and check against
    enc x5, x2, x0     # encode
    dec x6, x5, x0      # x6 should be 0x1234
    bne x6, x2, FAIL1

    li x2, 0xf9
    slli x2, x2, 8
    ori x2, x2, 0x75  
    enc x5, x2, x0     
    dec x6, x5, x0      # x6 should be 0xf975
    bne x6, x2, FAIL1

    li x2, 0x97
    slli x2, x2, 8
    ori x2, x2, 0x1a  
    enc x5, x2, x0   
    dec x6, x5, x0      # x6 should be 0x971a
    beq x6, x2, TEST2   # move to next test
    nop
    nop
    nop
    nop

    FAIL1:
    nop
    nop
    nop
    nop
    halt
    nop
    nop
    nop
    nop
    nop


    # Test 2, 1 error, tested in each bit position [0-21]
    TEST2: // test setup
    li x1, 1  // value to store bit error
    li x4, 0  // count bit position
    li x5, 22  // check when all bits have been tested
    slli x3, x1, 30
    or x3, x3, x6  // x3 stores 0x4000971a (expected value)

    SUBROUTINE2: // test 2 loop
    enc x7, x2, x0     # value to write
    xor x7, x7, x1    # add bit error
    dec x8, x7, x0      # x8 should be 0x4000971a (in all of these cases)
    bne x8, x3, FAIL2
    addi x4, x4, 1
    beq x4, x5, TEST3 // check if all bit positions have been tested (if successful, move to test 3)
    slli x1, x1, 1 // increment bit error position
    j SUBROUTINE2
    nop
    nop
    nop
    nop

    FAIL2:
    nop
    nop
    nop
    nop
    halt
    nop
    nop
    nop
    nop
    nop

    FAIL3:
    nop
    nop
    nop
    nop
    halt
    nop
    nop
    nop
    nop
    nop

    // Test 3, 2 errors
    TEST3:
    li x3, 1
    slli x3, x3, 31  # x3 holds 0x80000000
    enc x9, x2, x0     # value to write
    xori x9, x9, 0x30  # 2-bit error
    dec x10, x9, x0    # x10 should be 0x80000000
    bne x3, x10, FAIL3
    enc x9, x2, x0     
    xori x9, x9, 0x9 
    dec x10, x9, x0      # x10 should be 0x80000000
    bne x3, x10, FAIL3
    enc x9, x2, x0     
    xori x9, x9, 0x500  
    dec x10, x9, x0      # x10 should be 0x80000000
    bne x3, x10, FAIL3
    enc x9, x2, x0  
    li x11, 1   
    xor x9, x9, x11
    slli x11, x11, 20
    xor x9, x9, x11
    dec x10, x9, x0      # x10 should be 0x80000000
    bne x3, x10, FAIL3
    enc x9, x2, x0     
    xori x9, x9, 0xa0 
    dec x10, x9, x0      # x10 should be 0x80000000
    bne x3, x10, FAIL3
    enc x9, x2, x0    
    li x12, 0xa
    slli x12, x12, 16 
    xor x9, x9, x12
    dec x10, x9, x0      # x10 should be 0x80000000
    bne x3, x10, FAIL3
    enc x9, x2, x0     
    xori x9, x9, 0x41 
    dec x10, x9, x0      # x10 should be 0x80000000
    bne x3, x10, FAIL3
    nop
    nop
    nop
    nop


    SUCCESS:
    halt    // success if program reaches this point
    nop
    nop
    nop
    nop
    nop


