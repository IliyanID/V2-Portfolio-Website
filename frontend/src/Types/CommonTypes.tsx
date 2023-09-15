import { FunctionComponent, PropsWithChildren } from "react";

export type Component<P extends object = {}> = FunctionComponent<PropsWithChildren<P>>