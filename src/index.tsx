import { NativeModules } from 'react-native';

type BeaconsTracingType = {
  multiply(a: number, b: number): Promise<number>;
};

const { BeaconsTracing } = NativeModules;

export default BeaconsTracing as BeaconsTracingType;
