import React from "react";
import { Buffer } from "buffer";
import { create } from "ipfs-http-client";

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

  const CIDAndFileNameToURISuffix = (CID: string, fileName: string) =>
    CID + "?filename=" + fileName;

  return {
    client,
    CIDAndFileNameToURISuffix,
  };
}
