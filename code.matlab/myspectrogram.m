
function X = myspectrogram(x, N, w, M)
    % Computes the spectrogram of the input signal x[n].
    % 
    % Inputs:
    %   x - Input signal (vector)
    %   N - DFT length
    %   w - Overlapping window (vector of length N)
    %   M - Number of samples to shift after each DFT
    %
    % Output:
    %   X - Spectrogram matrix (magnitude squared of DFT)

    % Ensure x is a column vector
    x = x(:);
    w = w(:); % Ensure window is a column vector
    
    % Number of DFT points
    L = length(x);
    numFrames = floor((L - N) / M) + 1; % Number of frames
    X = zeros(N, numFrames); % Preallocate the spectrogram matrix

    for i = 1:numFrames
        % Define the current segment
        startIdx = (i-1)*M + 1;
        endIdx = startIdx + N - 1;
        
        if endIdx > L
            break; % Stop if the window exceeds the signal length
        end
        
        segment = x(startIdx:endIdx) .* w; % Windowed segment
        DFT = fft(segment, N); % Compute the DFT
        X(:, i) = abs(DFT).^2; % Magnitude squared
    end
end


