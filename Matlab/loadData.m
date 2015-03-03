disp('Loading LMS151 data...')
lms151File = './data/lms151.csv';
[lms151Data lms151Header] = parseRawCSV(lms151File);
lms151DataStruct = createLaserScanStruct(lms151Header, lms151Data);

disp('Loading LMS200 data...')
lms200File = './data/lms200.csv';
[lms200Data lms200Header] = parseRawCSV(lms200File);
lms200DataStruct = createLaserScanStruct(lms200Header, lms200Data);

disp('Loading Hokuyo data...')
hokuyoFile = './data/hokuyo.csv';
[hokuyoData hokuyoHeader] = parseRawCSV(hokuyoFile);
hokuyoDataStruct = createLaserScanStruct(hokuyoHeader, hokuyoData,5);

disp('Loading Velodyne data...')
velodyneFile = './data/velodyne.csv';
[velodyneData velodyneHeader] = parseRawCSV(velodyneFile);
% todo
