function [IFcells,IFHcells,IFVcells] = mkIF2D_compress(gout,S,mpas,kN)
  % make IRF tracers with 0's and 1's for 1:max(gout)
  % first horizontal and then vertical

  check_pulse = 1;

	IFcells = repmat(0,[size(S,1) length(mpas.refBottomDepth) max(gout)*kN]);
  for j = 1:max(gout) % maximum tracers needed horizontally
    % for i = 1:3
    for i = 1:kN
      for k = 1:length(mpas.refBottomDepth)
        % if mod(k,3) == mod(i,3)
        if mod(k,kN) == mod(i,kN)
          ind = find(gout == j);
          % IFcells(ind,k,i+(j-1)*3) = 1;
          IFcells(ind,k,i+(j-1)*kN) = 1;
        end
    end
  end
  end
  
  % create an array of 0s with the shape of [j,k,max(gout)]
  % max(gout) gives the horizontal patterns needed for Impulse Function
  IFHcells = repmat(0,[size(S,1) length(mpas.refBottomDepth) max(gout)]);
  % create an array of 0s with the shape of [j,k,kN)] for vertical tendencies
  IFVcells = repmat(0,[size(S,1) length(mpas.refBottomDepth) kN]);
  
  for j = 1:max(gout) % maximum tracers needed horizontally
      for k = 1:length(mpas.refBottomDepth)
      % for k = 1:5:length(mpas.refBottomDepth) % test if pure horizontal 
          ind = find(gout == j);
          IFHcells(ind,k,j) = 1;
      end
  end

  for j = 1:kN
    for k = 1:length(mpas.refBottomDepth)
      if mod(k,kN) == mod(j,kN)
        IFVcells(:,k,j)=1;
      end
    end
  end
  
  % check if a wet point has a pulse for all stencils
  if check_pulse == 1
    disp('Now check Pulse...');
    for j = 1:size(IFHcells,2)
      for i = 1:size(IFHcells,1)
        if length(find(IFHcells(i,j,:) == 1)) ~= 1
          error('Each wet point should have 1 pulse !!');
        end
      end
    end
    disp('All wet points have 1 and only 1 pulse: well done!');
  end
  
end % end for makeIF2D
