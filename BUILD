# Copyright 2016, BeeswaxIO Inc.
#
# Build file for ctemplate libs.

load('ctemplate', 'generate_fsm_header')


COPTS = ['-Wall',
         '-Wwrite-strings',
         '-Woverloaded-virtual',
         '-Wno-sign-compare']

AUTOCONF_HDRS = ['ctemplate_build/linux-k8/ctemplate/template.h',
                 'ctemplate_build/linux-k8/ctemplate/template_cache.h',
                 'ctemplate_build/linux-k8/ctemplate/template_string.h',
                 'ctemplate_build/linux-k8/ctemplate/template_enums.h',
                 'ctemplate_build/linux-k8/ctemplate/template_pathops.h',
                 'ctemplate_build/linux-k8/ctemplate/template_modifiers.h',
                 'ctemplate_build/linux-k8/ctemplate/template_dictionary.h',
                 'ctemplate_build/linux-k8/ctemplate/template_dictionary_interface.h',
                 'ctemplate_build/linux-k8/ctemplate/template_annotator.h',
                 'ctemplate_build/linux-k8/ctemplate/template_emitter.h',
                 'ctemplate_build/linux-k8/ctemplate/template_namelist.h',
                 'ctemplate_build/linux-k8/ctemplate/per_expand_data.h',
                 'ctemplate_build/linux-k8/ctemplate/str_ref.h']
FSM_GEN_SRCS = ['upstream/src/htmlparser/htmlparser_fsm.h',
                'upstream/src/htmlparser/jsparser_fsm.h']

py_binary(name = 'generate_fsm',
          srcs = [ 'upstream/src/htmlparser/generate_fsm.py',
                   'upstream/src/htmlparser/fsm_config.py'])

generate_fsm_header(name = 'htmlparser_header',
                    src = 'upstream/src/htmlparser/htmlparser_fsm.config')

generate_fsm_header(name = 'jsparser_header',
                    src = 'upstream/src/htmlparser/jsparser_fsm.config')

cc_library(name = 'base',
           hdrs = ['upstream/src/base/arena-inl.h',
                   'upstream/src/base/arena.h',
                   'upstream/src/base/fileutil.h',
                   'upstream/src/base/macros.h',
                   'upstream/src/base/manual_constructor.h',
                   'upstream/src/base/mutex.h',
                   'upstream/src/base/small_map.h',
                   'upstream/src/base/thread_annotations.h',
                   'upstream/src/base/util.h',
                   'ctemplate_build/linux-k8/internal/config.h'],
           includes = ['ctemplate_build/linux-k8/internal/',
                       'upstream/src/'],
           srcs = ['upstream/src/base/arena.cc'],
           copts = COPTS)

cc_library(name = 'ctemplate',
           hdrs = AUTOCONF_HDRS,
           includes = ['ctemplate_build/linux-k8/',
                       'upstream/src/',
                       '$(GENDIR)/upstream/src/'],
           srcs = FSM_GEN_SRCS +
           ['ctemplate_build/linux-k8/ctemplate/find_ptr.h',
            'upstream/src/indented_writer.h',
            'upstream/src/per_expand_data.cc',
            'upstream/src/template.cc',
            'upstream/src/template_annotator.cc',
            'upstream/src/template_cache.cc',
            'upstream/src/template_dictionary.cc',
            'upstream/src/template_modifiers.cc',
            'upstream/src/template_modifiers_internal.h',
            'upstream/src/template_namelist.cc',
            'upstream/src/template_pathops.cc',
            'upstream/src/template_string.cc',
            'upstream/src/htmlparser/htmlparser.cc',
            'upstream/src/htmlparser/htmlparser.h',
            'upstream/src/htmlparser/htmlparser_cpp.h',
            'upstream/src/htmlparser/jsparser.cc',
            'upstream/src/htmlparser/jsparser.h',
            'upstream/src/htmlparser/statemachine.cc',
            'upstream/src/htmlparser/statemachine.h'],
           deps = [':base'],
           copts = COPTS,
           linkopts = ['-lm',
                       '-lpthread'],
           visibility = ['//visibility:public'])

exports_files(['upstream/src/template-converter'],
              visibility = ['//visibility:public'])

cc_binary(name = 'make_tpl_varnames_h',
          srcs = ['upstream/src/make_tpl_varnames_h.cc'],
          deps = [':ctemplate'])

cc_binary(name = 'diff_tpl_auto_escape',
          srcs = ['upstream/src/diff_tpl_auto_escape.cc'],
          deps = [':ctemplate'])

cc_library(name = 'ctemplate_test_util',
           hdrs = ['upstream/src/tests/config_for_unittests.h',
                   'upstream/src/tests/template_test_util.h'],
           includes = ['upstream/src/',
                       'upstream/src/tests/'],
           srcs = ['upstream/src/tests/template_test_util.cc',
                   'upstream/src/tests/config_for_unittests.h'],
           deps = [':base',
                   ':ctemplate'],
           linkopts = ['-lpthread'],
           testonly = 1)

cc_test(name = 'compile_test',
        srcs = ['upstream/src/tests/compile_test.cc'],
        deps = [':ctemplate'],
        size = 'small')

cc_test(name = 'template_test_util_test',
        srcs = ['upstream/src/tests/template_test_util_test.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        size = 'small')

cc_test(name = 'template_dictionary_unittest',
        srcs = ['upstream/src/tests/template_dictionary_unittest.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        copts = ['-Wno-sign-compare'],
        size = 'small')

cc_test(name = 'template_modifiers_unittest',
        srcs = ['upstream/src/tests/template_modifiers_unittest.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        size = 'small')

cc_test(name = 'template_setglobals_unittest',
        srcs = ['upstream/src/tests/template_setglobals_unittest.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        size = 'small')

cc_test(name = 'template_cache_test',
        srcs = ['upstream/src/tests/template_cache_test.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        size = 'small')

cc_test(name = 'template_unittest',
        srcs = ['upstream/src/tests/template_unittest.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        copts = ['-Wno-sign-compare',
                 '-Wno-unused-function'],
        size = 'small')

cc_test(name = 'template_regtest',
        srcs = ['upstream/src/tests/template_regtest.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        data = ['upstream/src/tests/template_unittest_test_footer.in',
                'upstream/src/tests/template_unittest_test_html.in',
                'upstream/src/tests/template_unittest_test_invalid1.in',
                'upstream/src/tests/template_unittest_test_invalid2.in',
                'upstream/src/tests/template_unittest_test_markerdelim.in',
                'upstream/src/tests/template_unittest_test_modifiers.in',
                'upstream/src/tests/template_unittest_test_nul.in',
                'upstream/src/tests/template_unittest_test_selective_css.in',
                'upstream/src/tests/template_unittest_test_selective_html.in',
                'upstream/src/tests/template_unittest_test_selective_js.in',
                'upstream/src/tests/template_unittest_test_simple.in',
                'upstream/src/tests/template_unittest_test_valid1.in',
                'upstream/src/tests/template_unittest_test_footer_dict01.out',
                'upstream/src/tests/template_unittest_test_footer_dict02.out',
                'upstream/src/tests/template_unittest_test_html_dict01.out',
                'upstream/src/tests/template_unittest_test_html_dict02.out',
                'upstream/src/tests/template_unittest_test_markerdelim_dict01.out',
                'upstream/src/tests/template_unittest_test_markerdelim_dict02.out',
                'upstream/src/tests/template_unittest_test_modifiers_dict01.out',
                'upstream/src/tests/template_unittest_test_nul_dict01.out',
                'upstream/src/tests/template_unittest_test_selective_css_dict01.out',
                'upstream/src/tests/template_unittest_test_selective_css_dict02.out',
                'upstream/src/tests/template_unittest_test_selective_html_dict01.out',
                'upstream/src/tests/template_unittest_test_selective_html_dict02.out',
                'upstream/src/tests/template_unittest_test_selective_js_dict01.out',
                'upstream/src/tests/template_unittest_test_selective_js_dict02.out',
                'upstream/src/tests/template_unittest_test_simple_dict01.out',
                'upstream/src/tests/template_unittest_test_simple_dict02.out',
                'upstream/src/tests/template_unittest_test_simple_dict03.out',
                'upstream/src/tests/template_unittest_test_valid1_dict01.out'],
        size = 'small')

cc_test(name = 'htmlparser_test',
        srcs = ['upstream/src/tests/htmlparser_cpp_test.cc'],
        deps = [':ctemplate',
                ':ctemplate_test_util'],
        data = ['upstream/src/tests/htmlparser_testdata/cdata.html',
                'upstream/src/tests/htmlparser_testdata/comments.html',
                'upstream/src/tests/htmlparser_testdata/context.html',
                'upstream/src/tests/htmlparser_testdata/google.html',
                'upstream/src/tests/htmlparser_testdata/javascript_attribute.html',
                'upstream/src/tests/htmlparser_testdata/javascript_block.html',
                'upstream/src/tests/htmlparser_testdata/javascript_regexp.html',
                'upstream/src/tests/htmlparser_testdata/position.html',
                'upstream/src/tests/htmlparser_testdata/reset.html',
                'upstream/src/tests/htmlparser_testdata/simple.html',
                'upstream/src/tests/htmlparser_testdata/tags.html'],
        size = 'small')

genrule(name = 'copy_statemachine',
        srcs = ['upstream/src/htmlparser/statemachine.cc'],
        outs = ['upstream/src/htmlparser/statemachine.c'],
        cmd = 'cp $< $@')

generate_fsm_header(name = 'statemachine_test_header',
                    src = 'upstream/src/tests/statemachine_test_fsm.config')

cc_test(name = 'statemachine_test',
        srcs = ['upstream/src/tests/statemachine_test.c',
                'upstream/src/tests/statemachine_test_fsm.h',
                'upstream/src/htmlparser/statemachine.c'],
        deps = [':ctemplate'],
        size = 'small')

cc_library(name = 'sample_fsm',
           includes = ['upstream/src'],
           textual_hdrs = ['upstream/src/tests/htmlparser_testdata/sample_fsm.c'],
           testonly = 1)

cc_test(name = 'generate_fsm_c_test',
        srcs = ['upstream/src/tests/generate_fsm_c_test.c'],
        deps = [':ctemplate',
                ':sample_fsm'],
        size = 'small')

sh_test(name = 'generate_fsm_test_sh',
        srcs = ['upstream/src/tests/generate_fsm_test.sh'],
        data = ['upstream/src/tests/htmlparser_testdata/sample_fsm.config',
                'upstream/src/tests/htmlparser_testdata/sample_fsm.c',
                'upstream/src/htmlparser/generate_fsm.py',
                'upstream/src/htmlparser/fsm_config.py'],
        args = [ './upstream'])

sh_test(name = 'make_tpl_varnames_h_unittest_sh',
        srcs = ['upstream/src/tests/make_tpl_varnames_h_unittest.sh'],
        data = [':make_tpl_varnames_h'],
        size = 'small')

sh_test(name = 'diff_tpl_auto_escape_unittest_sh',
        srcs = ['upstream/src/tests/diff_tpl_auto_escape_unittest.sh'],
        data = ['diff_tpl_auto_escape'],
        size = 'small')

