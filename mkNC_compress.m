function []=mkNC_compress(name,outfile,IFHcells,IFVcells)
%function []=mkNC_compress(name,outfile,IFHcells,IFVcells)
%name: initial file to read grid information
%outfile: output NetCDF file name
%IFHcells: horizontal IF stencils (repeat pattern every layer)
%IFVcells: vertical IF stencils (1 for every horizontal point,but 1 in every five layers)

% define MPAS resolution here
% dimensions of 240 km test case:
%         nEdges = 5754 ;
%         nCells = 1794 ;
%         TWO = 2 ;
%         maxEdges = 10 ;
%         nVertLevels = 40 ;
%         StrLen = 64 ;
%         Time = UNLIMITED ; // (1 currently)
%         maxEdges2 = 20 ;
%         nVertices = 3945 ;
%         vertexDegree = 3 ;


% setup netcdf format
ncformat = '64bit';

% the dimension info is read from file 'name'
 f = ncinfo(name);
 for i = 1:length(f.Dimensions)
     nccreate(outfile,f.Dimensions(i).Name,'Dimensions',{f.Dimensions(i).Name,f.Dimensions(i).Length},'format',ncformat);
 end

[filepath,bname,ext] = fileparts(f.Filename);
LL = structfind(f.Dimensions,'Name','nCells');
nCells_len = f.Dimensions(LL).Length;
LL = structfind(f.Dimensions,'Name','nVertLevels');
nVertL_len = f.Dimensions(LL).Length;
LL = structfind(f.Dimensions,'Name','Time');
nTime_len = f.Dimensions(LL).Length;

disp(['nCells: ' num2str(nCells_len) ' nVertLevels: ' num2str(nVertL_len) ' Time ' num2str(nTime_len)]);

% define global attributes
 ncwriteatt(outfile,'/','IF initialization','tracers with 1s and 0s') ;
 ncwriteatt(outfile,'/','Grid','MPAS-O unstructured');
 ncwriteatt(outfile,'/','resolution',bname);
%  for i = 1:length(f.Attributes)
%      ncwriteatt(outfile,f.Attributes(i).Name,'/',f.Attributes(i).Value);
%  end

IRF = permute(IFHcells,[2 1 3]);
% define variables
for i=1:size(IRF,3)
% for i=1:2
  scrsh = sprintf('%s %02d %s %s','now writing horizontal IF',i,'into file ',outfile);
  disp(scrsh);
  nccreate(outfile,['IFH' num2str(i,'%02d')],'Dimensions',{'nVertLevels',nVertL_len,'nCells',nCells_len,'Time',1},'format',ncformat);
  ncwrite(outfile,['IFH' num2str(i,'%02d')],IRF(:,:,i),[1 1 1]);
  ncwriteatt(outfile,sprintf('IFH%02d',i),'long_name',sprintf('IF horizontal tracers number %02d',i));
end

IRF = permute(IFVcells,[2 1 3]);
% define variables
for i=1:size(IRF,3)
% for i=1:2
  scrsh = sprintf('%s %02d %s %s','now writing vertical IF',i,'into file ',outfile);
  disp(scrsh);
  nccreate(outfile,['IFV' num2str(i,'%02d')],'Dimensions',{'nVertLevels',nVertL_len,'nCells',nCells_len,'Time',1},'format',ncformat);
  ncwrite(outfile,['IFV' num2str(i,'%02d')],IRF(:,:,i),[1 1 1]);
  ncwriteatt(outfile,sprintf('IFV%02d',i),'long_name',sprintf('IF vertical tracers number %02d',i));
end

% define dimensions variables
% nccreate(name,'nVertices','Dimensions',{'nVertices',inf},'format','classic');
% nccreate(name,'vertexDegree','Dimensions',{'vertexDegree',inf},'format','classic');


% define variables
% nccreate(name,'lat','Dimensions',{'j',jlat,'i',ilon},'format','classic');
% ncwrite(name,'lat',lat,[1 1]);
% ncwriteatt(name,'lat','long_name','Latitude in POP grid');
