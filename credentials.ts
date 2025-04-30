// config.ts

export const azureConfig = {
  tenantId: "fgnjghy5u8tyfug",
  clientId: "fnjuy87684958943fj",
  clientSecret: "ffjgkfiu9867495764958",
  subscriptionId: "gmnfku6987967845789",
  resourceGroupName: "YOUR_AZURE_RESOURCE_GROUP_NAME",
  storageAccountName: "YOUR_AZURE_STORAGE_ACCOUNT_NAME",
  storageAccountKey: "YOUR_AZURE_STORAGE_ACCOUNT_KEY",
  // ... other Azure-related configurations
};

// You would then import and use this config object in your application:
// import { azureConfig } from './config';
// console.log(azureConfig.tenantId);