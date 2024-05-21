dnl SPDX-License-Identifier: GPL-2.0
dnl
dnl Copyright 2018 Cray Inc. All rights reserved.

dnl CXI provider specific configuration

dnl Called to configure this provider
dnl
dnl Arguments:
dnl
dnl : action if configured successfully
dnl : action if not configured successfully
dnl

m4_include([config/fi_pkg.m4])

AM_CONDITIONAL([HAVE_PMI], [test "x" = "xtrue"])
AM_CONDITIONAL([HAVE_ZE], [test "" = "1" && test "" != ""])
AM_CONDITIONAL([HAVE_CUDA], [test "" = "1" && test "" != ""])
AM_CONDITIONAL([HAVE_ROCR], [test "" = "1" && test "" != ""])

AC_DEFUN([FI_CXI_CONFIGURE],[
        # Determine if we can support the cxi provider
        cxi_happy=0

        AS_IF([test x"" != x"no"],
                [FI_PKG_CHECK_MODULES([CXI], [libcxi],
                        [cxi_CPPFLAGS=
                        cxi_LDFLAGS=
                        cxi_happy=1],
                        [cxi_happy=0])])

        AS_IF([test "" != ""],
                [cxitest_CPPFLAGS="-I/include"
                cxitest_LDFLAGS="-L/lib64 -Wl,-rpath=/lib64"
                cxitest_LIBS="-lcriterion"
                have_criterion=true])

        AM_CONDITIONAL([HAVE_CRITERION], [test "x" = "xtrue"])

        AS_IF([test "" != ""],
                [have_pmi=true])

        AM_CONDITIONAL([HAVE_PMI], [test "x" = "xtrue"])

        AC_SUBST(cxi_CPPFLAGS)
        AC_SUBST(cxi_LDFLAGS)
        AC_SUBST(cxitest_CPPFLAGS)
        AC_SUBST(cxitest_LDFLAGS)
        AC_SUBST(cxitest_LIBS)

        AS_IF([test  -eq 1], [], [])
])
