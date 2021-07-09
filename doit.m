  % set testcase resolution (KM) for world ocean, available
  % are: 240km, 120km, 60km, 30km, 15km
  resolution   = 'QU240';

  % read restart file from test cases
  test_dir     = '/DFS-L/SCRATCH/moore/weiweif/MPAS-O/TestCases/';
  test_case    = ['MPAS-O_V6.0_EC60to30/'];
  restart_file = 'oEC60to30v3_60layer.170905.nc';
  filename     = [test_dir test_case restart_file];

  filename     = '../TestCases/ocean.EC30to60E2r2.200908.nc';
  outfile      = '../TestCases/tmp.nc';
  % low resolution
  filename     = '../TestCases/initial_state.nc';
  filename     = '/global/cscratch1/sd/mpeterse/runs/ocean_model_210204_irf_addition_irf_on/ocean/global_ocean/QU240/init/initial_state/initial_state_QU240_210207.nc';
  outfile      = '../TestCases/tmp_low_210207.nc';
  outfile      = '../TestCases_IFVH/QU240/tmp_low_v_1in5.nc';

  % get MPAS-O grid and find the number of IRF tracers
  % [gout,S,mpas] = mkS(filename);
  % generate 0 and 1 patterns
  % IFcells = mkIF2D(gout,S,mpas,3);
  % write IRFs to NETCDF file (append it to restart MPAS-O file)
  % mkNC(filename,outfile,IFcells);

  % generate compressed IFHcell and IFVcells
  [gout,S,mpas] = mkS_3_4_order(filename);
  [IFcells,IFHcells,IFVcells] = mkIF2D_compress(gout,S,mpas,5);
  % mkNC_compress(filename,outfile,IFHcells,IFVcells);

  % append IRFs to filename
  % file_new = '../TestCases/new.nc';
  % [status,cmdout] = unix(['cp ' filename ' ' file_new]);
  % [status,cmdout] = unix(['ncks -A -C -v IRF_* ' outfile ' ' file_new]);
  % save(sprintf('gout_%s.mat',resolution),'gout');
