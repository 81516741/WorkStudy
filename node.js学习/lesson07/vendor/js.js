/**
 * Created by ld on 16/10/17.
 */
var fibonacci = function (n) {
    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return 1;
    }
    return fibonacci(n-1) + fibonacci(n-2);
};
