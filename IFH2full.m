function IFcells = IFH2full(IFHcells,kN)
% function IFcells = IFH2full(IFHcells,kN)
% convert IFVcells to full IF tracers
% the number is hN(horizontal stencil number)*kN(3 or 5)

  [ny,nz,nN] = size(IFHcells);
	IFcells = repmat(0,[ny nz nN*kN]);
  for j = 1:nN % maximum tracers needed horizontally
    for i = 1:kN
      for k = 1:nz
        if mod(k,kN) == mod(i,kN)
          IFcells(:,k,i+(j-1)*kN) = IFHcells(:,k,j);
        end
    end
  end
  end
  
