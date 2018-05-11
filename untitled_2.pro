
;遍历文件夹的文件
fileDirectory = 'E:\GLAH14'
r = file_search(fileDirectory,'*.H5',count = num)
;print,num
;print,r

;符合条件的索引
minLat = 39.474390
maxLat = 40.084414
minLon = 116.175877
maxLon = 116.919788

latitude_name = 'Data_40HZ/Geolocation/d_lat'
lon_name = 'Data_40HZ/Geolocation/d_lon'
elev_name = 'Data_40HZ/Elevation_Surfaces/d_elev'
irecndx_name = 'Data_40HZ/Time/i_rec_ndx'
ishortCount_name = 'Data_40HZ/Time/i_shot_count'
igvalrcv_name = 'Data_40HZ/Waveform/i_gval_rcv'
idemElv_name = 'Data_40HZ/Geophysical/d_DEM_elv'
inumPk_name ='Data_40HZ/Waveform/i_numPk'
iDSUTCTime_name = 'Data_40HZ/DS_UTCTime_40'
dGsigma_name ='Data_40HZ/Waveform/d_Gsigma'
elevUseFlag_name = 'Data_40HZ/Quality/elev_use_flg'
satCorrFlg_name = 'Data_40HZ/Quality/sat_corr_flg' 
sigmaatt_name = 'Data_40HZ/Quality/sigma_att_flg'
reflctUncor_name = 'Data_40HZ/Reflectivity/d_reflctUC'
frirqaFlag_name = 'Data_40HZ/Atmosphere/FRir_qa_flg'

title = strcompress('theDateTime' + ' ' + 'lon' + ' ' + 'lat' + ' ' + 'elev'+ ' ' + 'irecndx'+ ' ' + 'ishortCount'+ ' ' + 'igvalrcv'+ ' ' + 'idemElv'+ ' ' + 'inumPk'+ ' ' + 'elevUseFlag'+ ' ' + 'satCorrFlg'+ ' ' + 'sigmaatt'+ ' ' + 'reflctUncor'+ ' ' + 'frirqaFlag'+ ' ' + 'strSigma')

outputFileName = 'E:\\test\\test3.txt'
openw, lun,outputFileName , /Get_Lun,WIDTH=2000.0


for i=0,num-1 do begin
  file_name = r(i)
  file_id = H5F_OPEN(file_name);

  ;纬度集
  latitude_id = H5D_OPEN(file_id,latitude_name)
  lat = H5D_READ(latitude_id)
  H5D_CLOSE,latitude_id

  ;经度集
  lon_id = H5D_OPEN(file_id,lon_name)
  lon = H5D_READ(lon_id)
  H5D_CLOSE,lon_id

  ;高程
  elev_id = H5D_OPEN(file_id,elev_name)
  elev = H5D_READ(elev_id)
  H5D_CLOSE,lon_id
  
  ;索引
  irecndx_id = H5D_OPEN(file_id,irecndx_name)
  irecndx = H5D_READ(elev_id)
  H5D_CLOSE,irecndx_id
  
  ;时间
  iDSUTCTime_id = H5D_OPEN(file_id,iDSUTCTime_name)
  iDSUTCTime = H5D_READ(iDSUTCTime_id)
  H5D_CLOSE,iDSUTCTime_id
  
  ;i_short_count
  ishortCount_id = H5D_OPEN(file_id,ishortCount_name)
  ishortCount = H5D_READ(ishortCount_id)
  H5D_CLOSE,ishortCount_id
  
  ;i_gval_rcv
  igvalrcv_id = H5D_OPEN(file_id,igvalrcv_name)
  igvalrcv = H5D_READ(igvalrcv_id)
  H5D_CLOSE,igvalrcv_id
  
  ;d_DEM_elv
  idemElv_id = H5D_OPEN(file_id,idemElv_name)
  idemElv = H5D_READ(idemElv_id)
  H5D_CLOSE,idemElv_id
  
  ;i_numPk
  inumPk_id = H5D_OPEN(file_id,inumPk_name)
  inumPk = H5D_READ(inumPk_id)
  H5D_CLOSE,inumPk_id
  
  ;d_Gsigma
  dGsigma_id = H5D_OPEN(file_id,dGsigma_name)
  dGsigma = H5D_READ(dGsigma_id)
  H5D_CLOSE,dGsigma_id
  
  ;elev_use_flg
  elevUseFlag_id = H5D_OPEN(file_id,elevUseFlag_name)
  elevUseFlag = H5D_READ(elevUseFlag_id)
  H5D_CLOSE,elevUseFlag_id
  
  ;sat_corr_flg
  satCorrFlg_id = H5D_OPEN(file_id,satCorrFlg_name)
  satCorrFlg = H5D_READ(satCorrFlg_id)
  H5D_CLOSE,satCorrFlg_id
  
  ;i_sigmaatt
  sigmaatt_id = H5D_OPEN(file_id,sigmaatt_name)
  sigmaatt = H5D_READ(sigmaatt_id)
  H5D_CLOSE,sigmaatt_id
  
  ;i_reflctUncor
  reflctUncor_id = H5D_OPEN(file_id,reflctUncor_name)
  reflctUncor = H5D_READ(reflctUncor_id)
  H5D_CLOSE,reflctUncor_id
  
  ;i_Frir_qaFlag
  frirqaFlag_id = H5D_OPEN(file_id,frirqaFlag_name)
  frirqaFlag = H5D_READ(frirqaFlag_id)
  H5D_CLOSE,frirqaFlag_id
  
  indiceLat = where(lat ge minLat and lat le maxLat )
  indiceLon = where(lon ge minLon and lon le maxLon )
  indice = where(lat ge minLat and lat le maxLat and lon ge minLon and lon le maxLon )

  numberOfIndice = N_ELEMENTS(indice)
  
  ;printf, lun, file_name
  ;print,file_name
  ;print,dGsigma(2,4) ;26
  ;printf,  lun,file_name
  ;printf,  lun,dGsigma(2,4);26
  ;判断集合是否为空,先判断大小大于等于1，再判断不为负数
  ;打印到控制台或文件
  if numberOfIndice ge 1 then begin
    if indice(0) ge 0 then begin
      ;print,' not empty'
      print, file_name
      printf, lun, file_name
      print, title
      printf, lun, title
      
      for j=0,numberOfIndice-1 do begin
        ;时间
        getSeconds = iDSUTCTime(indice(j))
        secondsofEachHour = 60.0 * 60.0 
        secondsofEachDay = secondsofEachHour * 24.0
        getDays = getSeconds / secondsofEachDay
        ;caldat只用于天数相加.可以为小数
        caldat,julday(1,1,2000,12,0,0) + getDays, month, day, year, hour,minute,second
        theDate = strcompress(strtrim(year) + '/'+strtrim(month)+'/'+strtrim(day),/REMOVE_ALL )
        theTime = strcompress(strtrim(hour)+':'+strtrim(minute)+':'+strtrim(second),/REMOVE_ALL )
        theDateTime = strcompress(theDate + ' ' + theTime)
     
        ;限定条件
        if inumPk(indice(j)) eq 1 then begin
          strSigma = dGsigma(0,indice(j))
          strTotal = strcompress(strtrim(theDateTime)+' '+strtrim(lon(indice(j)))+' '+strtrim(lat(indice(j)))+' '+strtrim(elev(indice(j)))+' '+strtrim(irecndx(indice(j)))+' '+strtrim(ishortCount(indice(j)))+' '+strtrim(igvalrcv(indice(j)))+' '+strtrim(idemElv(indice(j)))+' '+strtrim(inumPk(indice(j)))+' '+strtrim(elevUseFlag(indice(j)))+' '+strtrim(satCorrFlg(indice(j)))+' '+strtrim(sigmaatt(indice(j)))+' '+strtrim(reflctUncor(indice(j)))+' '+strtrim(frirqaFlag(indice(j))));+' '+strtrim(strSigma))
          ;print, strTotal
          ;printf, lun, strTotal
          print, theDateTime,lon(indice(j)),lat(indice(j)),elev(indice(j)), irecndx(indice(j)),ishortCount(indice(j)), igvalrcv(indice(j)), idemElv(indice(j)),inumPk(indice(j)), elevUseFlag(indice(j)),satCorrFlg(indice(j)),sigmaatt(indice(j)),reflctUncor(indice(j)),frirqaFlag(indice(j)), strSigma,indice(j)
          printf, lun,theDateTime,lon(indice(j)),lat(indice(j)),elev(indice(j)), irecndx(indice(j)),ishortCount(indice(j)), igvalrcv(indice(j)), idemElv(indice(j)),inumPk(indice(j)), elevUseFlag(indice(j)),satCorrFlg(indice(j)),sigmaatt(indice(j)),reflctUncor(indice(j)),frirqaFlag(indice(j)), strSigma,indice(j)
        endif
       endfor
    endif else begin
     ; print, 'empty'
     ; printf, lun, 'empty'
    endelse
  endif else begin
    ;print, 'empty'
     ; printf, lun, 'empty'
  endelse
endfor
Free_Lun, lun

end

;示例，连写,hi1 hi2 hi3
;openw, lun, 'E:\\test\\test3.txt', /Get_Lun
;printf, lun, 'hi1'
;printf, lun, 'hi2'
;printf, lun, 'hi3'
;Free_Lun, lun
;
;
;示例，同索引的数组，计算第三个数组的同索引值
;arr1 = [1,2,3,4,5,6,7,8,9,10]
;print, arr1
;arr2 = [6,7,8,9,10,11,20,25,66,30]
;print, arr2
;arr3 = [100,200,400,800,1600,3200,304,102,495,349,950]
;print, arr3
;minArr1 = 4
;maxArr1 = 9
;indiceArr1 = where(arr1 ge minArr1 and arr1 le maxArr1 )
;minArr2 = 11
;maxArr2 = 40
;indiceArr2 = where(arr2 ge minArr2 and arr2 le maxArr2 )
;indice = where(arr1 ge minArr1 and arr1 le maxArr1 and arr2 ge minArr2 and arr2 le maxArr2 )
;print, indiceArr1
;print, indiceArr2
;print, arr1(indiceArr1)
;print, arr2(indiceArr2)
;print, indice
;print, arr3[indice]