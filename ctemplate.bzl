# Copyright 2016, BeeswaxIO Inc.
#
# Bazel build rules for ctemplate

def generate_fsm_header(name, src):
    hdr_output = src[0:-7] + '.h'
    native.genrule(name = name,
                   srcs = [ src ],
                   outs = [ hdr_output ],
                   cmd = '$(location :generate_fsm) $< > $@',
                   tools = [ ':generate_fsm' ])
