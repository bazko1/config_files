function go_list_tests
    if test -z "$argv"
        echo "No arguments given"
        return 1
    end
     cat $argv | grep '^func Test[a-zA-Z0-9_]*\s*(t\s.testing.T)' | sed -n 's/.*\(Test[a-zA-Z0-9_]*\).*/\1/p' | jq -R -s -c 'split("\n")[:-1]'
end
