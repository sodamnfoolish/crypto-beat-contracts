import React from "react";
import { create } from "ipfs-http-client";
import { Buffer } from "buffer";

export function useIPFS() {
  const client = create({
    url: process.env.REACT_APP_INFURA_IPFS_API_ENDPOINT,
    headers: {
      authorization:
        "Basic " +
        Buffer.from(
          process.env.REACT_APP_INFURA_IPFS_PROJECT_ID +
            ":" +
            process.env.REACT_APP_INFURA_IPFS_API_KEY_SECRET
        ).toString("base64"),
    },
  });

  const fileNameAndCIDToUrl = (fileName: string, CID: string) =>
    process.env.REACT_APP_IPFS_URL + CID + "?filename=" + fileName;

  return {
    client,
    fileNameAndCIDToUrl,
  };
}
