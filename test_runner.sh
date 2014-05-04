#!/bin/bash
BIN=EIFGENs/test_suite/W_code
ec test_suite.e
./$BIN/test_suite | tee test_report.md
