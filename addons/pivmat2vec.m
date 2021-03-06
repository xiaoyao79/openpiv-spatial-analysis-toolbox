function pivmat2vec(directory,data,first)
% PIVMAT2VEC(DIRECTORY, V, FIRST)
% PIVMAT2VEC saves the data stored as the PIVMAT structure V into 
% DIRECTORY, while vec files will be numbered starting from the FIRST 
% See also SAVEVEC

%  SAVEVEC(DIRECTORY,DATA) saves DATA structure in CIL MAT format to INSIGHT VEC
%  format files in DIRECTORY
% Example:
% re2800 = rescale(load('re2800'),0.08/1888,15e-3);
% savevec('re2800',re2800,1500);
%
% 

% TITLE="C:\Experiments7\b\m\Analysis\m002000.T000.D000.P001.H002.L.vec" VARIABLES="X pixel", "Y pixel", "U pixel", "V pixel", "CHC", DATASETAUXDATA Application="PIV" DATASETAUXDATA SourceImageWidth="4008" DATASETAUXDATA SourceImageHeight="2672" DATASETAUXDATA LengthUnit="pixel" DATASETAUXDATA OriginInImageX="0.000000" DATASETAUXDATA OriginInImageY="2671.000000" DATASETAUXDATA MicrosecondsPerDeltaT="17000.000000" DATASETAUXDATA TimeUnit="deltaT" DATASETAUXDATA SecondaryPeakNumber="0" DATASETAUXDATA DewarpedImageSource="0" ZONE I=124, J=82, F=POINT
% 32.000000, 2639.000000, 0.000000, 0.000000, -2

% file name = m002000.T000.D000.P001.H002.L.vec

% Author: Alex Liberzon (alex dot liberzon at gmail dot com)
% Copyright (c) 1998-2012 OpenPIV group
% See the file license.txt for copying permission.

if ~exist(directory,'dir'), mkdir(directory); end;
[J,I] = size(data(1).vx);


x = data(1).x;
y = data(1).y;
[x,y] = meshgrid(x,y);



for i = 1:length(data)-1
    u = data(i).vx';
    v = data(i).vy';
    fname = sprintf('piv%06d.T000.D000.P001.H002.L.vec',i+first-1);
    header = sprintf('TITLE= %s VARIABLES= "X %s", "Y %s", "U %s", "V %s", "CHC",DATASETAUXDATA Application="PIV" DATASETAUXDATA SourceImageWidth="4008" DATASETAUXDATA SourceImageHeight="2672" DATASETAUXDATA LengthUnit="%s" DATASETAUXDATA OriginInImageX="0.000000" DATASETAUXDATA OriginInImageY="2671.000000" DATASETAUXDATA MicrosecondsPerDeltaT="17000.000000" DATASETAUXDATA TimeUnit="deltaT" DATASETAUXDATA SecondaryPeakNumber="0" DATASETAUXDATA DewarpedImageSource="0" ZONE I=%d, J=%d, F=POINT',...
    fname,data(1).unitx,data(1).unity,data(1).unitvx,data(1).unitvy,data(1).unitx,I,J);
    fid = fopen(fullfile(directory,fname),'w');
    fprintf(fid,'%s\n',header);
    fprintf(fid,'%10.6f, %10.6f, %10.6f, %10.6f, %d\n',[x(:),y(:),u(:),v(:), ones(size(u(:)))]');
    fclose(fid);
end