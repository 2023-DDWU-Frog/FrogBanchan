import NavbarExample from './NavbarExample';
import './App.css';

import 'bootstrap/dist/css/bootstrap.min.css';
// import React, { useState } from 'react';
// import Button from 'react-bootstrap/Button';
// import Offcanvas from 'react-bootstrap/Offcanvas';
import Badge from 'react-bootstrap/Badge';

// const options = [
//   {
//     name: 'offcanvas',
//     scroll: true,
//     backdrop: false,
//   }
// ];

const HorizonLine = ({ text }) => {
  return (
    <div
      style={{
        width: "100%",
        textAlign: "center",
        borderBottom: "1px solid #000",
        lineHeight: "0.1em",
        marginTop: 375,
      }}
    >
      <span style={{ background: "#fff", padding: "0 10px" }}>{text}</span>
    </div>
  );
};

const MemberCircle = ({ text }) => {
  return (
    <div
      style={{
        width: 90,
        height: 90,
        borderRadius: 100,
        marginLeft: 30,
        marginTop: 25,
        float: "left",
        border: "1px solid black",
      }}
    >
      <AddBadge></AddBadge>
      <p style={{ lineHeight: 5.5, }}>
        {text}
      </p>
    </div>
  );
};

const MemberSelected = ({ text }) => {
  return (
    <div
      style={{
        width: 90,
        height: 90,
        borderRadius: 100,
        marginLeft: 30,
        marginTop: 25,
        float: "left",
        border: "1px solid black",
      }}
    >
      <RemoveBadge></RemoveBadge>
      <p style={{ lineHeight: 5.5, }}>
        {text}
      </p>
    </div>
  );
};

const HateList = ({ text }) => {
  return (
    <span
      style={{
        fontSize: 24,
        margin: 20,
        textAlign: "center",
        textDecorationLine: "underline",
      }}
    >
      {text}
    </span>
  );
};

function AddBadge() {
  return (
    <div
      style={{
        position: "absolute",
        fontSize: 20,
        marginLeft: -5,
      }}
    >
      <Badge pill bg="primary">
        +
      </Badge>{' '}
    </div>
  );
}

function RemoveBadge() {
  return (
    <div
      style={{
        position: "absolute",
        fontSize: 20,
        marginLeft: -5,
      }}
    >
      <Badge pill bg="danger">
        X
      </Badge>{' '}
    </div>
  );
}

function GroupMain() {
  return (
    <div className="App">
      {/* <header className="App-header">

        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header> */}

      <body>

        <NavbarExample />

        <div
          style={{
            maxWidth: 800,
            height: 140,
            position: "absolute",
            marginTop: 130,
            marginLeft: "30%",
            overflowX: "scroll",
            overflowY: "scroll",
            whiteSpace: "nowrap",
            // border: "1px solid black",
          }}
        >
          <MemberCircle text="팀원1" />
          <MemberCircle text="팀원2" />
          <MemberCircle text="팀원4" />
          <MemberCircle text="팀원5" />
          <MemberCircle text="팀원6" />
          {/* <MemberCircle text="팀원8" />
          <MemberCircle text="팀원9" />
          <MemberCircle text="팀원10" /> */}
        </div>

        <div
          style={{
            width: 120,
            height: 50,
            borderRadius: 20,
            position: "absolute",
            marginTop: 337,
            marginLeft: "12%",
            overflow: "hidden",
            background: "#fff",
            border: "1px solid black",
          }}
        >
          <p
            style={{
              lineHeight: 2.4,
              fontSize: 20,
            }}
          >
            팀원 선택
          </p>
        </div>


        <div
          style={{
            width: 800,
            height: 140,
            position: "absolute",
            marginTop: 290,
            marginLeft: "30%",
            overflow: "hidden",
            background: "#fff",
          }}
        >
          <div
            style={{
              width: 800,
              height: 140,
              borderRadius: 30,
              background: "#fff",
              border: "2px solid black",
              overflow: "auto",
              whiteSpace: "nowrap",
            }}
          >
            <div
              style={{
                width: 90,
                height: 90,
                borderRadius: 100,
                marginLeft: 50,
                marginTop: 25,
                float: "left",
                border: "1px solid black",
              }}
            >
              <RemoveBadge></RemoveBadge>
              <p style={{ lineHeight: 5.5, }}>
                팀원3
              </p>
            </div>

            <MemberSelected text="팀원7" />
            {/* <MemberSelected text="팀원11" />
            <MemberSelected text="팀원12" />
            <MemberSelected text="팀원13" />
            <MemberSelected text="팀원14" />
            <MemberSelected text="팀원15" /> */}


          </div>
        </div>
        <HorizonLine text="" />

        <div
          style={{
            position: "absolute",
            marginLeft: "35%",
            marginTop: 145,
            padding: 10,
            background: "#fff",
            color: "red",
            fontSize: 20,
            zIndex: 1,
          }}
        >
          싫어요 리스트
        </div>
        <div
          style={{
            width: 800,
            height: 150,
            position: "absolute",
            marginTop: 170,
            marginLeft: "30%",
            background: "#fff",
          }}
        >
          <div
            style={{
              width: 800,
              height: 120,
              background: "#fff",
              border: "1px solid black",
            }}
          >
            <div style={{ marginTop: 40, }}>
              <HateList text={"회"} />
              <HateList text={"피자"} />
              <HateList text={"냉면"} />
            </div>
          </div>
          <p style={{ fontSize: 14, color: "gray", }}>
            현재 선택된 멤버들의 불호 음식 목록으로, 추천 메뉴에서 제외됩니다.
          </p>
        </div>

      </body>
    </div>
  );
}

export default GroupMain;


// function OffCanvasExample({ name, ...props }) {
//   const [show, setShow] = useState(false);

//   const handleClose = () => setShow(false);
//   const toggleShow = () => setShow((s) => !s);

//   return (
//     <>
//       <Button variant="primary" onClick={toggleShow} className="me-2">
//         {name}
//       </Button>
//       <Offcanvas show={show} onHide={handleClose} {...props}>
//         <Offcanvas.Header closeButton>
//           <Offcanvas.Title>Offcanvas</Offcanvas.Title>
//         </Offcanvas.Header>
//         <Offcanvas.Body>
//           Some text as placeholder. In real life you can have the elements you
//           have chosen. Like, text, images, lists, etc.
//         </Offcanvas.Body>
//       </Offcanvas>
//     </>
//   );
// }
