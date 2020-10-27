function IFcells = mkIF2D(gout,mpas)
  % make IRF tracers with 0's and 1's for 1:max(gout)
  
  IFcells = repmat(0,[size(S,1) length(mpas.refBottomDepth) 3*max(gout)]);
  
  for j = 1:max(gout) % maximum tracers needed horizontally
    for i = 1:3
      for k = 1:length(mpas.refBottomDepth)
        if mod(k,3) == mod(i,3)
          ind = find(gout == j);
          IFcells(ind,k,i+(j-1)*3) = 1;
        end
    end
  end
  end
  
  % check if a wet point has a pulse
  disp('Now check Pulse...');
  for j = 1:size(IFcells,2)
    for i = 1:size(IFcells,1)
      if length(find(IFcells(i,j,:) == 1)) ~= 1
        error('Each wet point should have 1 pulse !!');
      end
    end
  end
  disp('All wet points have 1 and only 1 pulse: well done!');
  
end % end for makeIF2D
