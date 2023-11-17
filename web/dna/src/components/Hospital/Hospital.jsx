import React, { useEffect, useState } from "react";
import styled from "styled-components";

const { kakao } = window;

const Hospital = () => {

  const [map, setMap] = useState(null)

  const [markers, setMarkers] = useState([]);
  const [places, setPlaces] = useState([]);
  const [selectedPlace, setSelectedPlace] = useState(
    parseInt(localStorage.getItem("selectedPlace"), 10) || null);
  const [infowindow, setInfowindow] = useState(null)

  

  const mapscript = (userLatitude, userLongitude) => {


    const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    const options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(userLatitude, userLongitude), //지도의 중심좌표.
      level: 4 //지도의 레벨(확대, 축소 정도)
    };

    const newMap = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    setMap(newMap)

    const newInfowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
    setInfowindow(newInfowindow)

    const ps = new kakao.maps.services.Places(newMap)

    function searchPlaces() {
      ps.categorySearch('HP8', placesSearchCB, { useMapBounds: true })
    }

    function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        const bounds = new kakao.maps.LatLngBounds();
        setPlaces(data);

        const newMarkers = data.map((place, index) => {
          const placePosition = new kakao.maps.LatLng(place.y, place.x);
          const marker = addMarker(newMap, placePosition, place.place_name);
          bounds.extend(placePosition);

          kakao.maps.event.addListener(marker, "click", function () {
            handleMarkerClick(marker, place.place_name, index)
            const listItem = document.getElementById(`place-${index}`);
            if (listItem) {
              listItem.click();
            }
          });

          return marker;
        });

        setMarkers(newMarkers);

        if (map) {
          map.setBounds(bounds);
        } else {
          console.error("map이 null 또는 undefined입니다.");
        }
      }
    }

    function addMarker(map, position, title) {
      const imageSrc = process.env.PUBLIC_URL + '/images/map_marker1.png';
      const imageSize = new kakao.maps.Size(36, 37)
      const markerImage = new kakao.maps.MarkerImage(
        imageSrc,
        imageSize
      )

      const marker = new kakao.maps.Marker({
        position: position,
        image: markerImage,
        title: title
      })

      marker.setMap(map)
      return marker
    }
    searchPlaces()
  }

  const handleMarkerClick = (marker, title, index) => {
    infowindow.close();

    const content = `<div>${title}</div>`;
    infowindow.setContent(content);
    infowindow.open(map, marker);

    setSelectedPlace(index);
    localStorage.setItem("selectedPlace", index.toString());
  };

  const handleListItemClick = (index) => {
    if(!map) {
      console.error("Map is not avilable")
      return
    }

    const marker = markers[index];
    const place = places[index];
    const placePosition = new kakao.maps.LatLng(place.y, place.x);

    map.setCenter(placePosition);
    handleMarkerClick(marker, place.place_name, index)
  };

  useEffect(() => {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const { latitude, longitude } = position.coords;
        mapscript(latitude, longitude)
      },
      (error) => {
        mapscript(35.146480, 126.922253)
      }
    )
  }, [])

  return (
    <HospitalBox>
      <ul id="places-list">
        {places.map((place, index) => (
          <li
            key={index}
            id={`place-${index}`}
            className={selectedPlace === index ? "selected" : ""}
            onClick={() => handleListItemClick(index)}
          >
            <ContentWrapper>
              <div>
                <strong>{place.place_name}</strong>
              </div>
              <div>{place.road_address_name || place.address_name}</div>
              <div>{place.phone}</div>
            </ContentWrapper>
            <hr />
          </li>
        ))}
      </ul>
      <div id="map" />
    </HospitalBox>
  )
};

export default Hospital;

const HospitalBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 50px;
  overflow: hidden;
  height : 855px;
  background-color: #f5f5f5;

  & #map {
    width: 900px;
    height: 700px;
    border-radius: 20px;
    margin-right: 300px;
    order: 2;
  }


  & ul {
    overflow-y: auto; 
    max-height: 700px; 
    padding: 0; 
    margin-left: 300px;
    order: 1;
  }

  & li {
    
    background-color: white;
    padding: 20px;
    width: 320px;
    height: 80px;
    cursor: pointer;
  }

  & li.selected {
    color: #2e2288; /* 파란색으로 변경할 스타일 */
  }

  & hr {
    margin-top: 17px;
  }

  @media only screen and (max-width: 1040px){
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 0px;

    & #map{
      order: 1;
      width:80% ;
      height: 400px;
      margin-right: 0px;

    }

    & ul{
      margin-top: 20px;
      order: 2;
    margin-left: 0px;
    max-height: 300px; 

    }
    & li {
    height: 60px;

    }
  }
`;

const ContentWrapper = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
`;
