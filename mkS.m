% set testcase resolution (KM) for world ocean, available
% are: 240km, 120km, 60km, 30km, 15km
%  resolution   = '120kmN';

% read restart file from test cases
%  test_dir     = '/DFS-L/SCRATCH/moore/weiweif/MPAS-O/TestCases/';
%  test_case    = ['MPAS-O_V6.0_EC60to30/'];
%  restart_file = 'oEC60to30v3_60layer.170905.nc';
%  filename     = [test_dir test_case restart_file];

function [gout,S,mpas] = mkS(filename)
% read grid information: lonCell, latCell, nEdgesOnCell, cellsOnCell
% use colgroup to find the number of IRFs

  % mpas = ncReadAll(filename,'get',[24 19 9 5 29]);
  % [...] the indices of needed variables
  mpas.lonCell        = ncread(filename,'lonCell',[1],[inf]);
  mpas.latCell        = ncread(filename,'latCell',[1],[inf]);
  mpas.refBottomDepth = ncread(filename,'refBottomDepth',[1],[inf]);
  mpas.nEdgesOnCell   = ncread(filename,'nEdgesOnCell',[1],[inf]);
  mpas.cellsOnCell    = ncread(filename,'cellsOnCell',[1 1],[inf inf]);

% find how many trancers are needed for Tracer-Transport Matrix
  c = double(mpas.cellsOnCell); % imax = max(c(:));
  maxEdges = size(mpas.cellsOnCell,1);
  imax = max(c(:));
  n = mpas.nEdgesOnCell;
  k = 1;
  for i = 1:imax; % loop over cell indices
    % cc = setdiff(c(1:n(i),i),[0]);
    % a cell is its own neighbor (index is added)
    cc = setdiff([i; c(1:n(i),i)],[0]);
    for j = 1:length(cc)
      ix(k) = i;
      iy(k) = cc(j);
      s(k) = 1;
      k = k+1;
    end
  end
  S = sparse(ix,iy,s);
  tic
  gout = mycolgroup(S);
  toc
  disp([num2str(max(gout(:))) ' IRF tracers are required to build TTM']);
 end % end makeS
