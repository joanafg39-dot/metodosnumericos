args = argv();
if length(args) >= 2
    a = str2double(args{1});
    b = str2double(args{2});
else
    a = 0.1;
    b = 0.2;
endif

printf("%.17g\n", a + b);