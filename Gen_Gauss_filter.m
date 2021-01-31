function filter = Gen_Gauss_filter(var, size_filter)
    if nargin == 1
        size_filter = 3;
    elseif nargin == 0
            var = 1;
            size_filter = 3;
    end
%     % column vector
%     A = zeros(size_filter, 1);
    center = floor(size_filter/2) +1;
%     for i = 1:size_filter
%         A(i,1) = 1/(2*pi*var)^0.5*exp(-(i-center)^2/(2*var));
%     end
%     B = A';
%     filter = A*B;
%     filter = filter/mean(filter, 'all')/size_filter^2;
    
    
    filter = zeros(size_filter);
    for i = 1:size_filter
        for j = 1:size_filter
            filter(i,j) = 1/(2*pi*var)*exp(-0.5*((i-center)^2+(j-center)^2)/var);
        end
    end
    filter = filter/sum(filter, 'all');
end