import { Component } from "../../Types/CommonTypes";
import styled from 'styled-components'

export const SplashScreen:Component = () => {
    return (
        <SplashScreenWrapper>
            <div className="header">header</div>
            <h2 className="name">Iliyan Dimitrov</h2>
            <div className="footer">footer</div>
            <div className="headshot"/>
        </SplashScreenWrapper>
    )
};
export const SplashScreenWrapper = styled.div`
    width: 100vw;
    height: 100vh;
    display: grid;
    grid-template-rows: 1fr 200px 1fr;
    grid-template-columns: 1fr 1fr;
    grid-template-areas: '
        header headshot
        name   headshot
        footer headshot
    ';
    .header {
        grid-area: header;
    }
    .headshot {
        grid-area: headshot;
    }
    .name { 
        grid-area: name;
    }
    .footer {
        grid-area: footer;
    }

    > * {
        border: 2px solid blue;
    }
`