import React, { useEffect, useState } from "react";
import styled from "styled-components";

const { kakao } = window;

const Hospitalapp = () => {
  const [markers, setMarkers] = useState([]);
  const [places, setPlaces] = useState([]);

  useEffect(() => {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const { latitude, longitude } = position.coords;
        mapscript(latitude, longitude);
      },
      (error) => {
        mapscript(35.160007, 126.851610);
      }
    );
  }, []);

  const mapscript = (userLatitude, userLongitude) => {
    const container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스
    const options = {
      //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(userLatitude, userLongitude), //지도의 중심좌표.
      level: 4, //지도의 레벨(확대, 축소 정도)
    };

    const map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

    const infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

    const ps = new kakao.maps.services.Places(map);
    searchPlaces();

    function searchPlaces() {
      ps.categorySearch("HP8", placesSearchCB, { useMapBounds: true });
    }

    function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        const bounds = new kakao.maps.LatLngBounds();
        setPlaces(data);

        data.forEach((place, index) => {
          const placePosition = new kakao.maps.LatLng(place.y, place.x);
          const marker = addMarker(placePosition);
          bounds.extend(placePosition);

          kakao.maps.event.addListener(marker, "click", function () {
            displayInfoWindow(marker, place.place_name);
          });
        });
        map.setBounds(bounds);
      }
    }

    function addMarker(position) {
      const imageSrc = process.env.PUBLIC_URL + "/images/map_marker.png";
      const imageSize = new kakao.maps.Size(36, 37);
      const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

      const marker = new kakao.maps.Marker({
        position: position,
        image: markerImage,
      });

      marker.setMap(map);
      setMarkers((prevMarkers) => [...prevMarkers, marker]);

      return marker;
    }

    function displayInfoWindow(marker, title) {
      const content = `<div>${title}</div>`;
      infowindow.setContent(content);
      infowindow.open(map, marker);
    }

    // // 지도에 마커를 표시하는 함수입니다
    // function displayMarker(place) {
    //   // 마커를 생성하고 지도에 표시합니다
    //   var marker = new kakao.maps.Marker({
    //     map: map,
    //     position: new kakao.maps.LatLng(place.y, place.x)
    //   });

    //   // 마커에 클릭이벤트를 등록합니다
    //   kakao.maps.event.addListener(marker, 'click', function () {
    //     // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
    //     infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
    //     infowindow.open(map, marker);
    //   });
    // }
  };

  // 전화걸기 함수
  const handleCall = (phoneNumber) => {
    window.Toaster.postMessage(JSON.stringify(phoneNumber));
  };
  return (
    <HospitalBox>
      <div id="map" />
      <ul>
        {places.map((place, index) => (
          <li key={index}>
            <div id="flexBox">
              <div>
                <div>
                  <strong>{place.place_name}</strong>
                </div>
                <div>{place.road_address_name || place.address_name}</div>
                <div>{place.phone}</div>
              </div>
              <div onClick={() => handleCall(place.phone)}>
                <img id="call" src="images/call_icon.png" />
              </div>
            </div>
            <hr />
          </li>
        ))}
      </ul>
    </HospitalBox>
  );
};

export default Hospitalapp;

const HospitalBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #ffffff;
  gap: 50px;
  overflow: hidden;
  height: 100vh;

  & #map {
    width: 100vw;
    height: 30vh;
    border-radius: 20px;
    border: 1px solid gray;
  }

  & ul {
    overflow-y: auto;
    max-height: 60vh;
    padding: 0;
  }

  & li {
    background-color: white;
    width: 100vw;
    height: 23vw;
  }

  & #flexBox {
    display: flex;
    justify-content: space-between;
  }

  & #call {
    width: 17vw;
    height: 17vw;
  }
`;
