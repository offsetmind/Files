#!/bin/sh

system_xml_directory=/Library/org.pqrs/KeyRemap4MacBook/app/KeyRemap4MacBook.app/Contents/Resources
#private_xml_directory=/noexists
private_xml_directory=~/Library/Application\ Support/KeyRemap4MacBook

system_xml_directory_devel=../../KeyRemap4MacBook/src/core/server/Resources

for command in \
    dump_data \
    dump_tree \
    dump_tree_all \
    dump_number \
    dump_identifier_except_essential \
    output_bridge_essential_configuration_enum_h \
    output_bridge_essential_configuration_default_values_c \
    output_bridge_essential_configuration_identifiers_m \
    ; do
    /bin/echo "${command}:"

    ############################################################
    /bin/echo -n "    old "

    /usr/bin/time /Library/org.pqrs/KeyRemap4MacBook/bin/dump_xml_compiler_result \
        $system_xml_directory "$private_xml_directory" $command > ~/$command.old

    ############################################################
    /bin/echo -n "    new "

    /usr/bin/time ../../KeyRemap4MacBook/src/bin/dump_xml_compiler_result/build/Release/dump_xml_compiler_result \
        $system_xml_directory "$private_xml_directory" $command > ~/$command.new

    ############################################################
    /bin/echo -n "    dev "

    /usr/bin/time ../../KeyRemap4MacBook/src/bin/dump_xml_compiler_result/build/Release/dump_xml_compiler_result \
        $system_xml_directory_devel "$private_xml_directory" $command > ~/$command.devel

    diff -u ~/$command.old ~/$command.new
    diff -u ~/$command.new ~/$command.devel
done
