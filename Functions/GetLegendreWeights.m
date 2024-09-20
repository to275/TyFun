function [wi,thetai] = GetLegendreWeights(M)
% [wi,thetai] = GetLegendreWeights(M)
% this function calculates the Gauss-Legendre weights and cos(theta)
% locations for use in Gauss-Legendre quadrature.
% Input: M, the highest order Legendre polynomial
% Output: w, and M x 1 vector containing the integration weights
% thetai, a M x 1 vector containing the theta points for integration such that legendreP(M,cos(thetai))=0.
%
% When evaluating the integral of f(\theat) across the domain \theta\in[0,pi], a coordinate
% transform from \theta to \cos\theta allows us to rewrite the integral as
% \int_0^\pi f(\theta) d\theta = \int_-1^1 f(\theta) d\cos\theta =
% sum_{i=0}^M w_i f(\theta_i) 
% where the last step is Gauss-Legendre quadrature and wi are the weights
% (from this function) and legendreP(M,\cos\theta_i) = 0.
%
% If this integral is contained within another integral (as is the case for
% sphereical integration and the subject of the example), this integration
% scheme can be combined with Gaussian Quadrature using the Fourier basis
% (sines and cosines). In this case, the summation is the same and we have
% \int_0^{2\pi} f(\phi) d\phi = \sum_{i=0}^N w_i f(\phi_i) = \sum_{i=0}^N
% 2\pi/N f(2i\pi/N)
% where N is the number of basis vectors (note that P_N = sin(nx)). The
% last step has added the (uniform) weights and the (evenly spaced)
% evaluation points.
%
% Examples
% Evaluate the spherical integral \int_0^2\pi \int_0^\pi f(\theta,\phi)
% \sin\theta d\theta d\phi with 5 Legendre polynomials and 10 Forier basis
% functions: P_N = {1, cos(x), sin(x), ..., cos(5x), sin(5x)}
% f = @(theta, phi) ;
% M = 5; N = 10;
% [wi,thetai] = GetLegendreWeights(M);
% phij = 2*pi/N * (0:N)';
% wj = 2*pi/N * ones([N,1]);
% I = wi' * f(thetai,phij) * wj;


syms x
% calculate the Gauss-Legendre weights
cosi = double(vpasolve(legendreP(M,x) == 0)); % zeros of the Mth order legendre polynomial
dPn = M*(legendreP(M-1,cosi)-cosi.*legendreP(M,cosi))./(1-cosi.^2);
wi = 2./((1-cosi.^2).*(dPn.^2));
thetai = acos(cosi);

end

