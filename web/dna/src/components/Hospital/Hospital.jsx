import React, { useEffect, useState } from "react";
import styled from "styled-components";

const { kakao } = window;

const Hospital = () => {

  const [markers, setMarkers] = useState([]);
  const [places, setPlaces] = useState([]);

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

  const mapscript = (userLatitude, userLongitude) => {
    const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    const options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(userLatitude, userLongitude), //지도의 중심좌표.
      level: 4 //지도의 레벨(확대, 축소 정도)
    };

    const map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

    const infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

    const ps = new kakao.maps.services.Places(map)
    searchPlaces()

    function searchPlaces() {
      ps.categorySearch('HP8', placesSearchCB, { useMapBounds: true })
    }

    function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        const bounds = new kakao.maps.LatLngBounds()
        setPlaces(data)

        data.forEach((place, index) => {
          const placePosition = new kakao.maps.LatLng(place.y, place.x)
          const marker = addMarker(placePosition, place.place_name)
          bounds.extend(placePosition)

          kakao.maps.event.addListener(marker, 'click', function () {
            displayInfoWindow(marker, place.place_name)
          })

          // 목록 아이템 클릭 시 해당 마커에 중심 위치 이동
          const listItem = document.getElementById(`place-${index}`)
          if (listItem) {
            listItem.addEventListener("click", () => {
              map.setCenter(placePosition);
              infowindow.setContent(`<div>${place.place_name}</div>`);
              infowindow.open(map, marker);
            });
          }
        }
        )
        map.setBounds(bounds)
      }
    }

    function addMarker(position, title) {
      const imageSrc = process.env.PUBLIC_URL + '/images/map_marker.png';
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
      setMarkers((prevMarkers) => [...prevMarkers, marker])

      return marker
    }

    function displayInfoWindow(marker, title) {
      const content = `<div>${title}</div>`
      infowindow.setContent(content)
      infowindow.open(map, marker)
    }
  }
  return (
    <HospitalBox>
      <ul>
        {places.map((place, index) => (
          <li key={index} id={`place-${index}`}>
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
  background-color: #f5f5f5;
  gap: 50px;
  overflow: hidden;
  height : 855px;

  & #map {
    width: 800px;
    height: 700px;
    border-radius: 20px;
    border: 1px solid gray;
  }


  & ul {
    overflow-y: auto; 
    max-height: 700px; 
    padding: 0; 
  }

  & li {
    background-color: white;
    padding: 20px;
    width: 300px;
    height: 80px;
    cursor: pointer;
  }

  & hr {
    margin-top: 17px;
  }
`;

const ContentWrapper = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
`;
