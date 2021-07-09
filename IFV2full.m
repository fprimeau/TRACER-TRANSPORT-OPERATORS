function IFcells = IFV2full(IFVcells,gout)
% function IFcells = IFV2full(IFVcells,gout)
% convert IFVcells to full IF tracers
% the number is 3(5)*hN(horizontal stencil number)

  % now read IFHcells from MPAS-O ouput (IRFoutput..., snapshot..., etc)
  % IFVcells = repmat(0,[size(S,1) length(mpas.refBottomDepth) kN]);
  [ny,nz,kN] = size(IFVcells);
	IFcells = repmat(0,[ny nz kN*max(gout)]);
  for j = 1:max(gout) % maximum tracers needed horizontally
    for i = 1:kN
          ind = find(gout == j);
          IFcells(ind,:,i+(j-1)*kN) = IFVcells(ind,:,i);
  end
  end

