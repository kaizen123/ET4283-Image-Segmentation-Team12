function countmap = hist_count(integral_image, width, hoi)
    % Count the frequency of neigborhoods given the integral image
    % Parameters:
    %   integral_image: cumulative values across columns and rows of an
    %                   image, matrix of size (M,N)
    %   width: width of the neighboring window, int
    %   hoi: upper or lower half of the neighboring window, int
    % Returns:
    %   countmap: frequency count in neighboring windows
    % Example:
    %   hist_1 = hist_count(integral_image, 9, 1);
    
    M = size(integral_image, 1);
    N = size(integral_image, 2);
    
    % padding
    pad = int8((width - 1) / 2);
    Ib(pad+1:end-pad-1, pad+1:end-pad-1) = integral_image;
    
    countmap = zeros([M , N]); 
    P = zeros([M + width, N + width]);
    Q = zeros([M + width, N + width]);
    R = zeros([M + width, N + width]);
    S = zeros([M + width, N + width]);
    Ib = zeros([M + width, N + width]);

    if hoi == 1
        % upper left values
        P(width+1 : end, width+1:end) = integral_image;
        % upper right
        Q(width+1 : end, 1:N) = integral_image;
        % lower left
        R(pad+1 : end-pad-1, width+1 : end) = integral_image;
        % lower right
        S(pad+1 : end-pad-1, 1 : N) = integral_image;
    elseif hoi == 2
        % upper left values
        P(pad+2 : end-pad, width +1 : end) = integral_image;
        % upper right
        Q(pad+2: end-pad, 1 : N) = integral_image;
        % lower left value
        R(1 : M, width+1 : end) = integral_image;
        % lower right
        S(1 : M , 1 : N) = integral_image;
    end
    
    % Ib
    Ib = P + S - Q - R;
    % countmap
    countmap(pad+1 : end-pad, pad+1 : end-pad) = ...
        Ib(width : end-width, width : end-width);
end