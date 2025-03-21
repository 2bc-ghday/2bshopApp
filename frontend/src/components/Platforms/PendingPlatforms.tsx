import { Flex, Spinner, Text } from "@chakra-ui/react"

const PendingPlatforms = () => {
  return (
    <Flex direction="column" align="center" justify="center" height="100%">
      <Spinner size="xl" />
      <Text mt={4}>Loading platforms...</Text>
    </Flex>
  )
}

export default PendingPlatforms