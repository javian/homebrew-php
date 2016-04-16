#:  * `php-debug-info`:
#:     Prints debug info for issue submission for PHP tap

output = []

system_php_output = IO.popen("env php -r 'echo phpversion();'", :err=>[:child, :out]) 
system_php = system_php_output.read
system_php_output.close

#system_php = `env php -r 'echo phpversion();'`


system_gcc_output = IO.popen("env gcc -v", :err=>[:child, :out]) 
system_gcc = system_gcc_output.read
system_gcc_output.close

system_php_v_output = IO.popen("env php -v", :err=>[:child, :out]) 
system_php_v = system_php_v_output.read
system_php_v_output.close

output << <<-EOS.undent
## Description

_Please describe the problem you are experiencing in this section_

## Context and Logs

Parameter | Value
--------- | ------------------
**OS X Version:**       | #{MacOS.full_version}
**Homebrew Version:**   | #{HOMEBREW_VERSION}
**Xcode Version:**      | #{MacOS::Xcode.version }
**PHP Version in use:** | #{system_php}

**Output of gcc -v:**
#{system_gcc.chomp}

**Output of php -v:**
#{system_php_v.chomp}

**Build logs:** _Link to public gist created with `brew gist-logs my-formula`_

EOS

output.join "\n"
puts output
