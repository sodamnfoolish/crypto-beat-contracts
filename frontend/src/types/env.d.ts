export declare global {
  namespace NodeJS {
    interface ProcessEnv {
      REACT_APP_CHAIN_ID: number;
      REACT_APP_INFURA_IPFS_API_ENDPOINT: string;
      REACT_APP_INFURA_IPFS_PROJECT_ID: string;
      REACT_APP_INFURA_IPFS_API_KEY_SECRET: string;
      REACT_APP_IPFS_URL: string;
      REACT_APP_SUBGRAPH_URL: string;
    }
  }
}
