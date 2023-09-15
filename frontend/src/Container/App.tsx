import { Component } from '../Types/CommonTypes';
import styled from 'styled-components';
import { SplashScreen } from './SplashScreen/SplashScreen';

export const App: Component = () => {
  return (
    <AppWrapper>
      <SplashScreen />
    </AppWrapper>
  );
};

export const AppWrapper = styled.div`
  width: 100vw;
  height: 100vh;
`;
