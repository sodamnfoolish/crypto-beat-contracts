import { ApolloClient, InMemoryCache, gql } from "@apollo/client";
import {
  OnSaleCryptoBeatGraphQLEntity,
  OnSaleCryptoBeatGraphQLResponse,
} from "../types/subgraph/on-sale-crypto-beat";
import {
  CryptoBeatGraphQLEntity,
  CryptoBeatGraphQLResponse,
} from "../types/subgraph/crypto-beat";

export function useSubGraph() {
  const client = new ApolloClient({
    uri: process.env.REACT_APP_SUBGRAPH_URL,
    cache: new InMemoryCache(),
  });

  const getCryptoBeats = async (): Promise<CryptoBeatGraphQLEntity[]> =>
    (
      await client.query<CryptoBeatGraphQLResponse>({
        query: gql`
          query getCryptoBeats {
            cryptoBeats {
              id
              creator
              creatorTimestamp
              owner
              ownerTimestamp
              url
              currentOnSaleCryptoBeatId
            }
          }
        `,
      })
    ).data.cryptoBeats;

  const getCryptoBeatsOnSale = async (): Promise<
    OnSaleCryptoBeatGraphQLEntity[]
  > =>
    (
      await client.query<OnSaleCryptoBeatGraphQLResponse>({
        query: gql`
          query getCryptoBeatsOnSale {
            onSaleCryptoBeats(where: { onSale: true }) {
              id
              onSale
              seller
              sellTimestamp
              buyer
              buyTimestamp
              cryptoBeatId
              cryptoBeatPrice
            }
          }
        `,
      })
    ).data.onSaleCryptoBeats;

  return {
    getCryptoBeats,
    getCryptoBeatsOnSale,
  };
}
