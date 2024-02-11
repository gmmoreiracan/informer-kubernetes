# BEGIN: Test case for SN_INSTANCE value
expected_value='dev185921'
actual_value=$(source /Users/marianamaglia/Downloads/informer-kubernetes-yaml/client-setup.sh && echo $SN_INSTANCE)
if [ "$actual_value" = "$expected_value" ]; then
    echo "Test passed: SN_INSTANCE value is correct"
else
    echo "Test failed: SN_INSTANCE value is incorrect"
fi
# END: Test case for SN_INSTANCE value