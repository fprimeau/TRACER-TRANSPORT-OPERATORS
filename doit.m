  % set testcase resolution (KM) for world ocean, available
  % are: 240km, 120km, 60km, 30km, 15km
  resolution   = '120kmN';

  % read restart file from test cases
  test_dir     = '/DFS-L/SCRATCH/moore/weiweif/MPAS-O/TestCases/';
  test_case    = ['MPAS-O_V6.0_EC60to30/'];
  restart_file = 'oEC60to30v3_60layer.170905.nc';
  filename     = [test_dir test_case restart_file];

  filename     = '../TestCases/ocean.EC30to60E2r2.200908.nc';
  outfile      = '../TestCases/tmp.nc';

  % get MPAS-O grid and find the number of IRF tracers
  [gout,S,mpas] = mkS(filename);

  % generate 0 and 1 patterns
  IFcells = mkIF2D(gout,S,mpas);

  % write IRFs to NETCDF file (append it to restart MPAS-O file)
  mkNC(filename,outfile,IFcells);

  % append IRFs to filename
  % file_new = '../TestCases/new.nc';
  % [status,cmdout] = unix(['cp ' filename ' ' file_new]);
  % [status,cmdout] = unix(['ncks -A -C -v IRF_* ' outfile ' ' file_new]);
