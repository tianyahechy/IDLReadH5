
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

;iElvUseFlag_name = ''
;isatCorrFlg_name = ''
;isigmaatt_name = ''
;ireflctUncor_name = ''
;iFrirqaFlag_name =''
;dgsigma_name =''
;inumPk_name =''

outputFileName = 'E:\\test\\test3.txt'
openw, lun,outputFileName , /Get_Lun

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
  
  ;时间
  irecndx_id = H5D_OPEN(file_id,irecndx_name)
  irecndx = H5D_READ(elev_id)
  H5D_CLOSE,irecndx_id
  
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
  
  ;i_ElvuseFlg
  ;i_satCorrFlg 
  ;i_sigmaatt
  ;i_reflctUncor
  ;i_Frir_qaFlag
  ;d_gsigma
  ;i_numPk
  
  indiceLat = where(lat ge minLat and lat le maxLat )
  indiceLon = where(lon ge minLon and lon le maxLon )
  indice = where(lat ge minLat and lat le maxLat and lon ge minLon and lon le maxLon )

  ;indice = [1,2,3]
  numberOfIndice = N_ELEMENTS(indice)
  
  ;判断集合是否为空,先判断大小大于等于1，再判断不为负数
  ;打印到控制台或文件
  if numberOfIndice ge 1 then begin
    if indice(0) ge 0 then begin
      ;print,' not empty'
      ;print, file_name
      printf, lun, file_name
      for j=0,numberOfIndice-1 do begin
        caldat,irecndx(indice(j)), month, day, year, hour,minute,second
        theDate = strcompress(strtrim(year) + '/'+strtrim(month)+'/'+strtrim(day),/REMOVE_ALL )
        theTime = strcompress(strtrim(hour)+':'+strtrim(minute)+':'+strtrim(second),/REMOVE_ALL )
        theDateTime = strcompress(theDate + ' ' + theTime)
        ;print, theDateTime,lon(indice(j)),lat(indice(j)),elev(indice(j)), ishortCount(indice(j)), igvalrcv(indice(j)), idemElv(indice(j))
       printf, lun,theDateTime,lon(indice(j)),lat(indice(j)),elev(indice(j)), ishortCount(indice(j)), igvalrcv(indice(j)), idemElv(indice(j))
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