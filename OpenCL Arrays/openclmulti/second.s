# mark_description "Intel(R) C++ Intel(R) 64 Compiler XE for applications running on Intel(R) 64, Version 15.0.0.090 Build 20140";
# mark_description "723";
# mark_description "-S -o second.s -lm";
	.file "second.cpp"
	.text
..TXTST0:
# -- Begin  main
	.text
# mark_begin;
       .align    16,0x90
	.globl main
main:
# parameter 1: %edi
# parameter 2: %rsi
..B1.1:                         # Preds ..B1.0
..___tag_value_main.1:                                          #19.1
        pushq     %rbp                                          #19.1
..___tag_value_main.3:                                          #
        movq      %rsp, %rbp                                    #19.1
..___tag_value_main.4:                                          #
        andq      $-128, %rsp                                   #19.1
        pushq     %r12                                          #19.1
        subq      $120, %rsp                                    #19.1
        xorl      %esi, %esi                                    #19.1
        movl      $3, %edi                                      #19.1
        call      __intel_new_feature_proc_init                 #19.1
..___tag_value_main.6:                                          #
                                # LOE rbx r12 r13 r14 r15
..B1.11:                        # Preds ..B1.1
        stmxcsr   (%rsp)                                        #19.1
        movl      $4, %eax                                      #22.3
        xorl      %edx, %edx                                    #20.2
        orl       $32832, (%rsp)                                #19.1
        ldmxcsr   (%rsp)                                        #19.1
        movd      %eax, %xmm0                                   #22.3
        xorl      %eax, %eax                                    #20.2
        pshufd    $0, %xmm0, %xmm1                              #22.3
        movdqa    .L_2il0floatpacket.0(%rip), %xmm0             #22.3
        .align    16,0x90
                                # LOE rax rdx rbx r12 r13 r14 r15 xmm0 xmm1
..B1.2:                         # Preds ..B1.2 ..B1.11
        cvtdq2ps  %xmm0, %xmm2                                  #22.18
        paddd     %xmm1, %xmm0                                  #22.3
        cvtdq2ps  %xmm0, %xmm3                                  #22.18
        paddd     %xmm1, %xmm0                                  #22.3
        cvtdq2ps  %xmm0, %xmm4                                  #22.18
        paddd     %xmm1, %xmm0                                  #22.3
        cvtdq2ps  %xmm0, %xmm5                                  #22.18
        movaps    %xmm2, hA(,%rdx,4)                            #22.3
        paddd     %xmm1, %xmm0                                  #22.3
        movaps    %xmm3, 16+hA(,%rdx,4)                         #22.3
        movaps    %xmm4, 32+hA(,%rdx,4)                         #22.3
        movaps    %xmm5, 48+hA(,%rdx,4)                         #22.3
        addq      $16, %rdx                                     #20.2
        cmpq      $131072, %rdx                                 #20.2
        jb        ..B1.2        # Prob 99%                      #20.2
                                # LOE rax rdx rbx r12 r13 r14 r15 xmm0 xmm1
..B1.4:                         # Preds ..B1.2 ..B1.4
        movaps    hA(,%rax,4), %xmm3                            #25.10
        movaps    16+hA(,%rax,4), %xmm7                         #25.10
        movaps    32+hA(,%rax,4), %xmm11                        #25.10
        movaps    48+hA(,%rax,4), %xmm15                        #25.10
        rsqrtps   %xmm3, %xmm1                                  #25.10
        rsqrtps   %xmm7, %xmm5                                  #25.10
        rsqrtps   %xmm11, %xmm9                                 #25.10
        rsqrtps   %xmm15, %xmm13                                #25.10
        movaps    .L_2il0floatpacket.4(%rip), %xmm0             #25.10
        movaps    .L_2il0floatpacket.4(%rip), %xmm4             #25.10
        andps     %xmm3, %xmm0                                  #25.10
        movaps    .L_2il0floatpacket.4(%rip), %xmm8             #25.10
        andps     %xmm7, %xmm4                                  #25.10
        movaps    .L_2il0floatpacket.4(%rip), %xmm12            #25.10
        andps     %xmm11, %xmm8                                 #25.10
        movaps    .L_2il0floatpacket.3(%rip), %xmm2             #25.10
        andps     %xmm15, %xmm12                                #25.10
        movaps    .L_2il0floatpacket.3(%rip), %xmm6             #25.10
        movaps    .L_2il0floatpacket.3(%rip), %xmm10            #25.10
        movaps    .L_2il0floatpacket.3(%rip), %xmm14            #25.10
        cmpleps   %xmm0, %xmm2                                  #25.10
        cmpleps   %xmm4, %xmm6                                  #25.10
        cmpleps   %xmm8, %xmm10                                 #25.10
        cmpleps   %xmm12, %xmm14                                #25.10
        andps     %xmm1, %xmm2                                  #25.10
        andps     %xmm5, %xmm6                                  #25.10
        andps     %xmm9, %xmm10                                 #25.10
        andps     %xmm13, %xmm14                                #25.10
        mulps     %xmm2, %xmm3                                  #25.10
        mulps     %xmm6, %xmm7                                  #25.10
        mulps     %xmm10, %xmm11                                #25.10
        mulps     %xmm14, %xmm15                                #25.10
        mulps     %xmm3, %xmm2                                  #25.10
        mulps     %xmm7, %xmm6                                  #25.10
        mulps     %xmm11, %xmm10                                #25.10
        subps     .L_2il0floatpacket.1(%rip), %xmm2             #25.10
        mulps     %xmm15, %xmm14                                #25.10
        subps     .L_2il0floatpacket.1(%rip), %xmm6             #25.10
        subps     .L_2il0floatpacket.1(%rip), %xmm10            #25.10
        mulps     %xmm2, %xmm3                                  #25.10
        subps     .L_2il0floatpacket.1(%rip), %xmm14            #25.10
        mulps     %xmm6, %xmm7                                  #25.10
        mulps     %xmm10, %xmm11                                #25.10
        mulps     %xmm14, %xmm15                                #25.10
        mulps     .L_2il0floatpacket.2(%rip), %xmm3             #25.10
        mulps     .L_2il0floatpacket.2(%rip), %xmm7             #25.10
        mulps     .L_2il0floatpacket.2(%rip), %xmm11            #25.10
        mulps     .L_2il0floatpacket.2(%rip), %xmm15            #25.10
        movaps    %xmm3, hB(,%rax,4)                            #25.2
        movaps    %xmm7, 16+hB(,%rax,4)                         #25.2
        movaps    %xmm11, 32+hB(,%rax,4)                        #25.2
        movaps    %xmm15, 48+hB(,%rax,4)                        #25.2
        addq      $16, %rax                                     #25.10
        cmpq      $131072, %rax                                 #25.10
        jb        ..B1.4        # Prob 99%                      #25.10
                                # LOE rax rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.4
        movl      $65536, %edx                                  #27.13
        movq      %rdx, %r12                                    #27.13
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.7 ..B1.5
        movss     hA(,%r12,4), %xmm2                            #29.13
        pxor      %xmm1, %xmm1                                  #31.3
        sqrtss    %xmm2, %xmm2                                  #29.13
        movss     hB(,%r12,4), %xmm0                            #32.25
        movl      $.L_2__STRING.0, %esi                         #31.3
        movl      %r12d, %edx                                   #31.3
        cvtss2sd  %xmm0, %xmm0                                  #31.3
        cvtss2sd  %xmm2, %xmm1                                  #31.3
        movd      %xmm2, %r8d                                   #31.3
        movl      $2, %eax                                      #31.3
        movq      stderr(%rip), %rdi                            #31.3
        movl      hB(,%r12,4), %ecx                             #31.3
        call      fprintf                                       #31.3
                                # LOE rbx r12 r13 r14 r15
..B1.7:                         # Preds ..B1.6
        incq      %r12                                          #27.41
        cmpq      $65600, %r12                                  #27.29
        jle       ..B1.6        # Prob 98%                      #27.29
                                # LOE rbx r12 r13 r14 r15
..B1.8:                         # Preds ..B1.7
        xorl      %eax, %eax                                    #36.9
        addq      $120, %rsp                                    #36.9
..___tag_value_main.7:                                          #36.9
        popq      %r12                                          #36.9
        movq      %rbp, %rsp                                    #36.9
        popq      %rbp                                          #36.9
..___tag_value_main.8:                                          #
        ret                                                     #36.9
        .align    16,0x90
..___tag_value_main.10:                                         #
                                # LOE
# mark_end;
	.type	main,@function
	.size	main,.-main
	.data
# -- End  main
	.text
# -- Begin  _Z13LookAtTheBitsf
	.text
# mark_begin;
       .align    16,0x90
	.globl _Z13LookAtTheBitsf
_Z13LookAtTheBitsf:
# parameter 1: %xmm0
..B2.1:                         # Preds ..B2.0
..___tag_value__Z13LookAtTheBitsf.11:                           #42.1
        movd      %xmm0, %eax                                   #44.10
        ret                                                     #44.10
        .align    16,0x90
..___tag_value__Z13LookAtTheBitsf.13:                           #
                                # LOE
# mark_end;
	.type	_Z13LookAtTheBitsf,@function
	.size	_Z13LookAtTheBitsf,.-_Z13LookAtTheBitsf
	.data
# -- End  _Z13LookAtTheBitsf
	.bss
	.align 64
	.align 64
	.globl hA
hA:
	.type	hA,@object
	.size	hA,524288
	.space 524288	# pad
	.space 512	# pad
	.align 64
	.globl hB
hB:
	.type	hB,@object
	.size	hB,524288
	.space 524288	# pad
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.0:
	.long	0x00000000,0x00000001,0x00000002,0x00000003
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,16
	.align 16
.L_2il0floatpacket.1:
	.long	0x40400000,0x40400000,0x40400000,0x40400000
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,16
	.align 16
.L_2il0floatpacket.2:
	.long	0xbf000000,0xbf000000,0xbf000000,0xbf000000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,16
	.align 16
.L_2il0floatpacket.3:
	.long	0x00800000,0x00800000,0x00800000,0x00800000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,16
	.align 16
.L_2il0floatpacket.4:
	.long	0x7fffffff,0x7fffffff,0x7fffffff,0x7fffffff
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,16
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.0:
	.long	979645989
	.long	538976288
	.long	775106853
	.long	673211958
	.long	807761968
	.long	539588664
	.long	538976288
	.long	858858784
	.long	543569454
	.long	628633640
	.long	695744560
	.word	10
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,46
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
	.4byte 0x0000001c
	.8byte 0x00507a0100000000
	.4byte 0x09107801
	.byte 0x00
	.8byte __gxx_personality_v0
	.4byte 0x9008070c
	.2byte 0x0001
	.byte 0x00
	.4byte 0x0000004c
	.4byte 0x00000024
	.8byte ..___tag_value_main.1
	.8byte ..___tag_value_main.10-..___tag_value_main.1
	.2byte 0x0400
	.4byte ..___tag_value_main.3-..___tag_value_main.1
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_main.4-..___tag_value_main.3
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_main.6-..___tag_value_main.4
	.8byte 0xff800d1c380e0c10
	.8byte 0xfffffff80d1affff
	.2byte 0x0422
	.4byte ..___tag_value_main.7-..___tag_value_main.6
	.2byte 0x04cc
	.4byte ..___tag_value_main.8-..___tag_value_main.7
	.4byte 0xc608070c
	.byte 0x00
	.4byte 0x0000001c
	.4byte 0x00000074
	.8byte ..___tag_value__Z13LookAtTheBitsf.11
	.8byte ..___tag_value__Z13LookAtTheBitsf.13-..___tag_value__Z13LookAtTheBitsf.11
	.8byte 0x0000000000000000
# End
